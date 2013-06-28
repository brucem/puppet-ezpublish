# Class ezpublish::standalone::default
#
# Generates a standalone eZPublish system where eZ publish can be installed as
# the default docroot
#
class ezpublish::default(
  $docroot            = '/var/www/web',
  $docroot_owner      = $ezpublish::params::vhost_docroot_owner,
  $docroot_group      = $ezpublish::params::vhost_docroot_group,
  $ezp_environment    = $ezpublish::params::default_ezp_environment,
  $ezp_major_version  = $ezpublish::params::default_ezp_major_version,
){

  require ezpublish

  $default_conf_file = '/etc/apache2/conf.d/ezpublish'

  file {'/var/www/':
    ensure  => 'directory',
    owner   => $docroot_owner,
    group   => $docroot_group,
    require => Class['ezpublish'],
  }

  file {'/var/www/index.html':
    ensure  => 'absent',
    require => File['/var/www/'],
  }

  file{ $default_conf_file:
    ensure  => 'present',
    content => template( 'ezpublish/ezpublish-default.erb'),
    notify  => Service['httpd'],
    require => Class['ezpublish'],
  }
}
