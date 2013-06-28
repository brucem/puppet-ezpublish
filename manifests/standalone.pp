# Class ezpublish::standalone
#
# Generates a standalone eZ Publish system
# e.g. webserver + database server
#
class ezpublish::standalone (
  $php_modules      = $ezpublish::params::php_module_list,
  $pear_packages    = $ezpublish::params::php_pear_package_list,
  $system_packages  = $ezpublish::params::package_list,
  $db_root_password = $ezpublish::params::default_db_root_password
)
inherits ezpublish::params {

  class { 'ezpublish':
    php_modules       => $php_modules,
    pear_packages     => $pear_packages,
    system_packages   => $system_packages,
  }

  class {'ezpublish::database_server':
    root_password => $db_root_password
  }

}
