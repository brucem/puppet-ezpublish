# Definition: ezpublish::vhost
#
# This class installs Apache Virtual Hosts
#
# Parameters:
# - The $port to configure the host on
# - The $docroot provides the DocumentationRoot variable
# - The $serveradmin will specify an email address for Apache that it will
#   display when it renders one of it's error pages
# - The $configure_firewall option is set to true or false to specify if
#   a firewall should be configured.
# - The $ssl option is set true or false to enable SSL for this Virtual Host
# - The $template option specifies whether to use the default template or
#   override
# - The $priority of the site
# - The $servername is the primary name of the virtual host
# - The $serveraliases of the site
# - The $options for the given vhost
# - The $override for the given vhost (array of AllowOverride arguments)
# - The $vhost_name for name based virtualhosting, defaulting to *
# - The $logroot specifies the location of the virtual hosts logfiles, default
#   to /var/log/<apache log location>/
# - The $access_log specifies if *_access.log directives should be configured.
# - The $ensure specifies if vhost file is present or absent.
#
# Actions:
# - Install Apache Virtual Hosts suitable for running eZ publish
#
# Requires:
# - The ezpublish class
#
# Sample Usage:
#  ezpublish::vhost { 'site.name.fqdn':
#  }
#
define ezpublish::vhost(
  $port               = 80,
  $docroot            = "${ezpublish::params::vhost_docroot}/${name}",
  $docroot_owner      = $ezpublish::params::vhost_docroot_owner,
  $docroot_group      = $ezpublish::params::vhost_docroot_group,
  $serveradmin        = false,
  $configure_firewall = true,
  $ssl                = $apache::params::ssl,
  $template           = $ezpublish::params::vhost_template,
  $priority           = $apache::params::priority,
  $servername         = $apache::params::servername,
  $serveraliases      = $apache::params::serveraliases,
  $auth               = $apache::params::auth,
  $redirect_ssl       = $apache::params::redirect_ssl,
  $options            = $ezpublish::params::vhost_options,
  $override           = $apache::params::override,
  $apache_name        = $apache::params::apache_name,
  $vhost_name         = $apache::params::vhost_name,
  $logroot            = "/var/log/${apache::params::apache_name}",
  $access_log         = true,
  $ezp_environment    = $ezpublish::params::default_ezp_environment,
  $ezp_major_version  = $ezpublish::params::default_ezp_major_version,
  $ensure             = 'present'
)
{

  require ezpublish

  apache::vhost{ $name:
    ensure             => $ensure,
    port               => $port,
    docroot            => $docroot,
    docroot_owner      => $docroot_owner,
    docroot_group      => $docroot_group,
    serveradmin        => $serveradmin,
    configure_firewall => $configure_firewall,
    ssl                => $ssl,
    template           => $template,
    priority           => $priority,
    servername         => $servername,
    serveraliases      => $serveraliases,
    auth               => $auth,
    redirect_ssl       => $redirect_ssl,
    options            => $options,
    override           => $override,
    apache_name        => $apache_name,
    vhost_name         => $vhost_name,
    logroot            => $logroot,
    access_log         => $access_log
  }
}
