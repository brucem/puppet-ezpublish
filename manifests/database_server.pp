# Class ezpublish::database
#
# Installs mysql server
#
require mysql::params

class ezpublish::database_server (
  $config_file             = $mysql::params::config_file,
  $manage_config_file      = $mysql::params::manage_config_file,
  $old_root_password       = $mysql::params::old_root_password,
  $override_options        = {},
  $package_ensure          = $mysql::params::server_package_ensure,
  $package_name            = $mysql::params::server_package_name,
  $purge_conf_dir          = $mysql::params::purge_conf_dir,
  $remove_default_accounts = false,
  $restart                 = $mysql::params::restart,
  $root_group              = $mysql::params::root_group,
  $root_password           = $ezpublish::params::default_db_root_password,
  $service_enabled         = $mysql::params::server_service_enabled,
  $service_manage          = $mysql::params::server_service_manage,
  $service_name            = $mysql::params::server_service_name,
  $service_provider        = $mysql::params::server_service_provider
) inherits ezpublish::params {

  class { 'mysql::server':
    config_file             => $config_file,
    manage_config_file      => $manage_config_file,
    old_root_password       => $old_root_password,
    override_options        => $override_options,
    package_ensure          => $package_ensure,
    package_name            => $package_name,
    purge_conf_dir          => $purge_conf_dir,
    remove_default_accounts => $remove_default_accounts,
    restart                 => $restart,
    root_group              => $root_group,
    root_password           => $root_password,
    service_enabled         => $service_enabled,
    service_manage          => $service_manage,
    service_name            => $service_name,
    service_provider        => $service_provider,
  }
}
