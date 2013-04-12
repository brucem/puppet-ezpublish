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
class ezpublish {
  include ezpublish::params

  # Apache
  class {'apache':  }

  apache::mod { 'rewrite': }

  # Apache PHP module
  class {'apache::mod::php': }

  # MySQL client
  class { 'mysql': }

  # PHP configuration
  class { 'php': }

  php::module{ $ezpublish::params::php_module_list:
    notify  => Service['httpd'],
    require => Class['php'],
  }

  php::pear::module{ $ezpublish::params::php_pear_package_list:
    notify  => Service['httpd'],
    require => Class['php'],
  }

  # Install any required packages
  package{ $ezpublish::params::package_list:
    ensure => present,
  }

}
