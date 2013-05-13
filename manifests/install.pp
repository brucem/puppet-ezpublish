#
# This define allows eZ Publish to be downloaded, extracted and setup ready for
# instalation.
#
# TODO: Consider replacing with a shell script
#
define ezpublish::install(
  $file_name,     # Name of the file to find in the url and continue calling it on disk
  $download_url,  # URL file name, should not end in a "/"
  $destination    # Where to extract the file (the root of the eZ Publish install),
                  # should not end in a "/"
)
{
  require ezpublish::params
  require apache::params

  # Make sure archive folder exists
  file{ $ezpublish::params::version_archive:
    ensure => 'directory',
  }

  # Make sure cache folder is cleared, in case of prior runs using vagrant reload
  file{ "${destination}/ezpublish/cache/":
    ensure  => 'absent',
    recurse => true,
    force   => true,
    require => File[$ezpublish::params::version_archive],
  }

  # Ensure we have a local copy of the eZ Publish version
  download_file { $file_name:
    site    => $download_url,
    cwd     => $ezpublish::params::version_archive,
    creates => "${ezpublish::params::version_archive}/${name}",
    require => File["${destination}/ezpublish/cache/"],
  }

  # Extract the distribution into the DocRoot
  extract_file { "${ezpublish::params::version_archive}/${file_name}":
    dest    => $destination,
    options => '--strip-components=1',
    user    => $apache::params::user,
    notify  => [Enforce_perms["Enforce g+rw ${destination}"], Service['httpd']],
    require => Download_file[$file_name],
  }

  # Ensure the group can read and write the files
  enforce_perms{ "Enforce g+rw ${destination}":
    dir     => $destination,
    perms   => 'g+rw',
    require => Extract_file[ "${ezpublish::params::version_archive}/${file_name}" ],
  }

  #
  # Post extraction asset linking tasks
  #
  exec{ "eZPublish link assets ${destination}":
    command => 'php ezpublish/console assets:install --symlink web',
    onlyif  => 'php ezpublish/console list | grep assets:install',
    cwd     => $destination,
    user    => $apache::params::user,
    creates => "${destination}/web/bundles/framework",
    require => Enforce_perms["Enforce g+rw ${destination}"],
  }

  exec{ "eZPublish link legacy assets ${destination}":
    command => 'php ezpublish/console ezpublish:legacy:assets_install --symlink web',
    onlyif  => 'php ezpublish/console list | grep ezpublish:legacy:assets_install',
    cwd     => $destination,
    user    => $apache::params::user,
    creates => "${destination}/web/var",
    require => Exec["eZPublish link assets ${destination}"],
  }

  # New for eZ Publish Community Project 2013.4
  # Do not fail on non 0 return
  exec{ "Assetic dump ${destination}":
    command => 'php ezpublish/console assetic:dump --env=prod web || exit 0',
    onlyif  => 'php ezpublish/console list | grep assetic:dump',
    cwd     => $destination,
    user    => $apache::params::user,
    creates => "${destination}/web/js",
    require => Exec["eZPublish link legacy assets ${destination}"],
  }

}

# Utility definations
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
  $site    = '',
  $cwd     = '',
  $creates = '')
  {
    exec { $name:
      command => "wget ${site}/${name}",
      cwd     => $cwd,
      creates => "${cwd}/${name}",
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
