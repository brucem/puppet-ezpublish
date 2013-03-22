# Class ezpublish::standalone
#
# Generates a standalone eZ Publish system
# e.g. webserver + database server
#
class ezpublish::standalone inherits ezpublish {
  include ezpublish::params
  include ezpublish::database_server
}
