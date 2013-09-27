# Class: ezpublish
#
# Class to install an eZ publish base webserver
#
# Actions
#  - Install Apache
#  - install Mysql client
#  - Install PHP
#  - Install Required PHP modules
#  - Install required packages
class ezpublish (
  $php_modules     = $ezpublish::params::php_module_list,
  $pear_packages   = $ezpublish::params::php_pear_package_list,
  $system_packages = $ezpublish::params::package_list,
) inherits ezpublish::params {

  # Apache
  class {'apache':
    default_vhost => false,
    mpm_module    => 'prefork',
  }

  apache::mod { 'rewrite': }

  # Apache PHP module
  class {'apache::mod::php': }

  # MySQL client
  class { 'mysql': }

  # PHP configuration
  class { 'php': }

  php::module{ $php_modules:
    notify  => Service['httpd'],
    require => Class['php'],
  }

  php::pear::module{ $pear_packages:
    notify  => Service['httpd'],
    require => Class['php'],
  }

  # Install any required packages
  package{ $system_packages:
    ensure => present,
  }

}
