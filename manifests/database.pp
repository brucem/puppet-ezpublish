# Class ezpublish::database
#
define ezpublish::database (
  $db_user,
  $db_pass,
  $db_host    = $ezpublish::params::default_db_host,
  $db_priv    = $ezpublish::params::default_db_priv,
  $db_charset = $ezpublish::params::default_db_charset,
  $db_collate = $ezpublish::params::default_db_collate,
  $ensure     = 'present'
) {

  mysql::db{ $name:
    ensure   => $ensure,
    user     => $db_user,
    password => $db_pass,
    charset  => $db_charset,
    collate  => $db_collate,
    host     => $db_host,
    grant    => $db_priv,
  }

}
