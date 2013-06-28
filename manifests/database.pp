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

  database_user { $user:
    ensure        => $ensure,
    password_hash => mysql_password($db_pass),
  }

  database_grant { $userdb:
    privileges => $db_priv,
  }

  database { $name:
    ensure  => $ensure,
    require => Database_Grant[$userdb],
  }

}
