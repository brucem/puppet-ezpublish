# Class ezpublish::database
#
# Installs mysql server
#
class ezpublish::database_server (
  $config_hash      = {},
  $enabled          = true,
  $manage_service   = true,
  $root_password    = $ezpublish::params::default_db_root_password
) inherits ezpublish::params {

  include stdlib

  $merged_config_hash = merge($config_hash, { 'root_password' => $root_password })

  class { 'mysql::server':
    enabled          => $enabled,
    config_hash      => $merged_config_hash,
    manage_service   => $manage_service,
  }
}
