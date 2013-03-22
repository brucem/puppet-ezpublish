# Class: ezpublish::params
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class ezpublish::params {
  $php_module_list = ['mysql', 'gd', 'mcrypt', 'imagick', 'curl', 'xsl']

  $php_pear_package_list = [ 'apc' ]

  $package_list =['imagemagick']

  $default_db_root_password = '654yOuShouLdReaLLyChanGeThIS542'
}
