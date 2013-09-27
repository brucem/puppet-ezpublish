#
# This define allows eZ Publish to be downloaded, extracted and setup ready for
# instalation.
#
# TODO: Consider replacing with a shell script
#
define ezpublish::install(
  $src,  # URL or file path of destribution to install
  $dest  # Where to install files
)
{

  Exec {
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd  => '/',
  }

  require ezpublish::params
  require apache::params

  $filename = inline_template('<%= File.basename(@src) %>')

  file{ $ezpublish::params::version_archive:
    ensure => 'directory',
  }

  if ($src =~ /^http(|s):\/\// )
  {
    # Download to local archive
    download_file { $filename:
      src     => $src,
      dest    => $ezpublish::params::version_archive,
      require => File[$ezpublish::params::version_archive],
      notify  => Extract_file["${ezpublish::params::version_archive}/${filename}"],
    }
  } else {
    # Copy to local archive
    copy_file { $filename:
      src     => $src,
      dest    => $ezpublish::params::version_archive,
      require => File[$ezpublish::params::version_archive],
      notify  => Extract_file["${ezpublish::params::version_archive}/${filename}"],
    }
  }

  # This is requireed as the apache::vhost resource will create the docroot.
  # Yes it is a hack
  exec { "Remove ${dest}/web":
    command => "rmdir ${dest}/web",
    unless  => "test $(ls -A ${dest} | wc -l) -gt 1"
  }

  # Extract the source into the destination as long as the destination is empty
  extract_file { "${ezpublish::params::version_archive}/${filename}":
    dest    => $dest,
    user    => $apache::params::user,
    options => '--strip-components=1 --overwrite',
    onlyif  => "test $(ls -A ${dest} | wc -l) -le 1",
    notify  => [Enforce_perms["Enforce g+rw ${dest}"], Service['httpd']],
    require => Exec[ "Remove ${dest}/web" ],
  }

  # Ensure the group can read and write the files
  enforce_perms{ "Enforce g+rw ${dest}":
    dir     => $dest,
    perms   => 'g+rw',
    require => Extract_file[ "${ezpublish::params::version_archive}/${filename}" ],
  }

  #
  # Post extraction asset linking tasks
  #
  exec{ "eZPublish link assets ${dest}":
    command => 'php ezpublish/console assets:install --symlink web',
    onlyif  => 'php ezpublish/console list | grep assets:install',
    cwd     => $dest,
    user    => $apache::params::user,
    creates => "${dest}/web/bundles/framework",
    require => Enforce_perms["Enforce g+rw ${dest}"],
  }

  exec{ "eZPublish link legacy assets ${dest}":
    command => 'php ezpublish/console ezpublish:legacy:assets_install --symlink web',
    onlyif  => 'php ezpublish/console list | grep ezpublish:legacy:assets_install',
    cwd     => $dest,
    user    => $apache::params::user,
    creates => "${dest}/web/var",
    require => Exec["eZPublish link assets ${dest}"],
  }

  # New for eZ Publish Community Project 2013.4
  # Do not fail on non 0 return
  exec{ "Assetic dump ${dest}":
    command => 'php ezpublish/console assetic:dump --env=prod web || exit 0',
    onlyif  => 'php ezpublish/console list | grep assetic:dump',
    cwd     => $dest,
    user    => $apache::params::user,
    creates => "${dest}/web/js",
    require => Exec["eZPublish link legacy assets ${dest}"],
  }

}

# Utility definitions
define extract_file(
  $dest,
  $options = '',
  $user    = 'root',
  $onlyif  = 'test true' )
{
  exec { $name:
    command => "tar xzf ${name} -C ${dest} ${options}",
    user    => $user,
    onlyif  => $onlyif,
  }
}

define download_file(
  $src,
  $dest
)
{
  $filename = inline_template('<%= File.basename(@src) %>')
  exec { "Download ${src} to ${dest}":
    command => "wget ${src} -O ${dest}/${filename}",
    creates => "${dest}/${filename}",
  }
}

define copy_file(
  $src,
  $dest
)
{
  $filename = inline_template('<%= File.basename(@src) %>')
  exec { "Copy ${src} to ${dest}":
    command => "cp ${src} ${dest}/${filename}",
    creates => "${dest}/${filename}",
  }
}

define enforce_perms(
  $dir,
  $perms
)
{
  exec { "enforce ${dir} permissions":
    command => "chmod -R ${perms} ${dir}",
    onlyif  => "test \$(/usr/bin/find ${dir} ! -perm -${perms} | wc -l) -gt 0",
  }
}
