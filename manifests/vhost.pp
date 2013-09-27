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
  $install_dir,
  $virtual_docroot             = false,
  $port                        = 80,
  $ip                          = undef,
  $ip_based                    = false,
  $add_listen                  = true,
  $docroot_owner               = 'root',
  $docroot_group               = 'root',
  $serveradmin                 = false,
  $ssl                         = false,
  $ssl_cert                    = $apache::default_ssl_cert,
  $ssl_key                     = $apache::default_ssl_key,
  $ssl_chain                   = $apache::default_ssl_chain,
  $ssl_ca                      = $apache::default_ssl_ca,
  $ssl_crl_path                = $apache::default_ssl_crl_path,
  $ssl_crl                     = $apache::default_ssl_crl,
  $ssl_certs_dir               = $apache::params::ssl_certs_dir,
  $priority                    = undef,
  $default_vhost               = false,
  $servername                  = $name,
  $serveraliases               = [],
  $options                     = ['FollowSymLinks'],
  $override                    = ['None'],
  $vhost_name                  = '*',
  $logroot                     = $apache::logroot,
  $access_log                  = true,
  $access_log_file             = undef,
  $access_log_pipe             = undef,
  $access_log_syslog           = undef,
  $access_log_format           = undef,
  $aliases                     = undef,
  $directories                 = undef,
  $error_log                   = true,
  $error_log_file              = undef,
  $error_log_pipe              = undef,
  $error_log_syslog            = undef,
  $scriptalias                 = undef,
  $proxy_dest                  = undef,
  $proxy_pass                  = undef,
  $sslproxyengine              = false,
  $suphp_addhandler            = $apache::params::suphp_addhandler,
  $suphp_engine                = $apache::params::suphp_engine,
  $suphp_configpath            = $apache::params::suphp_configpath,
  $no_proxy_uris               = [],
  $redirect_source             = '/',
  $redirect_dest               = undef,
  $redirect_status             = undef,
  $rack_base_uris              = undef,
  $request_headers             = undef,
  $rewrite_rule                = undef,
  $rewrite_cond                = undef,
  $setenv                      = [],
  $setenvif                    = [],
  $block                       = [],
  $ensure                      = 'present',
  $wsgi_daemon_process         = undef,
  $wsgi_daemon_process_options = undef,
  $wsgi_process_group          = undef,
  $wsgi_script_aliases         = undef,
  $custom_fragment             = undef,
  $itk                         = undef,
  $ezp_major_version           = $ezpublish::params::default_ezp_major_version,
  $ensure                      = 'present'
)
{

  require ezpublish

  $ez_custom_fragment = template( 'ezpublish/ezpublish-vhost.erb' )

  if ! defined(File[$install_dir]) {
    file { $install_dir:
      ensure  => directory,
      owner   => $docroot_owner,
      group   => $docroot_group,
      require => Package['httpd'],
    }
  }

  if $ezp_major_version == '5' {
    $docroot = "${install_dir}/web"
  } else {
    $docroot = $install_dir
  }

  apache::vhost{ $name:
    ensure                      => $ensure,
    docroot                     => $docroot,
    virtual_docroot             => $virtual_docroot,
    port                        => $port,
    ip                          => $ip,
    ip_based                    => $ip_based,
    add_listen                  => $add_listen,
    docroot_owner               => $docroot_owner,
    docroot_group               => $docroot_group,
    serveradmin                 => $serveradmin,
    ssl                         => $ssl,
    ssl_cert                    => $ssl_cert,
    ssl_key                     => $ssl_key,
    ssl_chain                   => $ssl_chain,
    ssl_ca                      => $ssl_ca,
    ssl_crl_path                => $ssl_crl_path,
    ssl_crl                     => $ssl_crl,
    ssl_certs_dir               => $ssl_certs_dir,
    priority                    => $priority,
    default_vhost               => $default_vhost,
    servername                  => $servername,
    serveraliases               => $serveraliases,
    options                     => $options,
    override                    => $override,
    vhost_name                  => $vhost_name,
    logroot                     => $logroot,
    access_log                  => $access_log,
    access_log_file             => $access_log_file,
    access_log_pipe             => $access_log_pipe,
    access_log_syslog           => $access_log_syslog,
    access_log_format           => $access_log_format,
    aliases                     => $aliases,
    directories                 => $directories,
    error_log                   => $error_log,
    error_log_file              => $error_log_file,
    error_log_pipe              => $error_log_pipe,
    error_log_syslog            => $error_log_syslog,
    scriptalias                 => $scriptalias,
    proxy_dest                  => $proxy_dest,
    proxy_pass                  => $proxy_pass,
    sslproxyengine              => $sslproxyengine,
    suphp_addhandler            => $suphp_addhandler,
    suphp_engine                => $suphp_engine,
    suphp_configpath            => $suphp_configpath,
    no_proxy_uris               => $no_proxy_uris,
    redirect_source             => $redirect_source,
    redirect_dest               => $redirect_dest,
    redirect_status             => $redirect_status,
    rack_base_uris              => $rack_base_uris,
    request_headers             => $request_headers,
    rewrite_rule                => $rewrite_rule,
    rewrite_cond                => $rewrite_cond,
    setenv                      => $setenv,
    setenvif                    => $setenvif,
    block                       => $block,
    wsgi_daemon_process         => $wsgi_daemon_process,
    wsgi_daemon_process_options => $wsgi_daemon_process_options,
    wsgi_process_group          => $wsgi_process_group,
    wsgi_script_aliases         => $wsgi_script_aliases,
    custom_fragment             => $ez_custom_fragment,
  }
}
