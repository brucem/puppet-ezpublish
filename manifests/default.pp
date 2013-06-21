# Class ezpublish::standalone::default
#
# Generates a standalone eZPublish system where eZ publish can be installed as
# the default docroot
#
class ezpublish::default inherits ezpublish {
  require ezpublish::params

  # TODO: This should be a parameter
  $default_conf_file = '/etc/apache2/conf.d/ezpublish'
  $docroot = '/var/www/web'
  $ezp_environment = $ezpublish::params::default_ezp_environment

  file {'/var/www/':
    ensure => 'directory',
    owner  => $ezpublish::params::vhost_docroot_owner,
    group  => $ezpublish::params::vhost_docroot_group,
  }

  file {'/var/www/index.html':
    ensure => 'absent',
  }

  file{ $default_conf_file:
    ensure  => 'present',
    content => template( 'ezpublish/ezpublish-default.erb'),
    notify  => Service['httpd'],
  }
}
