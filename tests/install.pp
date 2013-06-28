class{ 'ezpublish::default' }
ezpublish::install { 'eZ Publish Community Project 2013.4':
  src  => 'http://share.ez.no/content/download/149574/883017/version/1/file/ezpublish5_community_project-2013.4-gpl-full.tar.gz',
  dest => '/var/www'
}

