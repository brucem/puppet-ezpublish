# Class ezpublish::database
#
# Installs mysql server
#
class ezpublish::database_server(
  $root_password = $ezpublish::params::default_db_root_password
){
  require ezpublish::params

  class { 'mysql::server':
      config_hash => { 'root_password' => $root_password }
  }
}
