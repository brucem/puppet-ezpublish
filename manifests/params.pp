# Class: ezpublish::params
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class ezpublish::params
{

  $php_default_date_timezone = 'Europe/London'

  $php_module_list = ['mysql', 'gd', 'mcrypt', 'imagick', 'curl', 'xsl']

  $php_pear_package_list = [ 'apc' ]

  $package_list =['imagemagick']

  $vhost_docroot = '/var/www'
  $vhost_docroot_owner = 'www-data'
  $vhost_docroot_group = 'www-data'
  $vhost_docroot_options = 'FollowSymLink'
  $vhost_template = 'ezpublish/vhost-default.conf.erb'

  $default_ezp_environment = 'prod'

  $default_db_host = 'localhost'
  $default_db_priv = ['all']
  $default_db_root_password = '654yOuShouLdReaLLyChanGeThIS542'

  # Where downloaded copies of eZ Publish are kept
  $version_archive = '/var/ezpublish-dist'
}

