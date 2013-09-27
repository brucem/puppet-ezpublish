# Class ezpublish::standalone::default
#
# Generates a standalone eZPublish system where eZ publish can be installed as
# the default docroot
#
class ezpublish::default(
  $install_dir        = '/var/www/default',
  $docroot_owner      = $ezpublish::params::vhost_docroot_owner,
  $docroot_group      = $ezpublish::params::vhost_docroot_group,
  $ezp_environment    = $ezpublish::params::default_ezp_environment,
  $ezp_major_version  = $ezpublish::params::default_ezp_major_version,
){

  require ezpublish

  ezpublish::vhost{ 'default':
    ensure            => present,
    install_dir       => $install_dir,
    port              => 80,
    docroot_owner     => $docroot_owner,
    docroot_group     => $docroot_group,
    setenv            => [ "ENVIRONMENT ${ezp_environment}" ],
    ezp_major_version => $ezp_major_version,
    default_vhost     => true,
  }

}
