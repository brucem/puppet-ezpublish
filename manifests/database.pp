# Class ezpublish::database
#
define ezpublish::database (
  $db_user,
  $db_pass,
  $db_host = $ezpublish::params::default_db_host,
  $db_priv = $ezpublish::params::default_db_priv,
  $ensure  = 'present'
) {

  $user   = "${db_user}@${db_host}"
  $userdb = "${user}/${name}"

  mysql_user { $user:
    ensure        => $ensure,
    password_hash => mysql_password($db_pass),
  }

  mysql_grant { $userdb:
    privileges => $db_priv,
  }

  mysql_database { $name:
    ensure  => $ensure,
    require => Database_Grant[$userdb],
  }

}
