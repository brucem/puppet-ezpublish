eZ Publish module for Puppet
===========================
eZ Publish is an open source Content management system and this module allows
for: 
- the configuration of base system
- default webserver configuration
- vhost configuration
- instalation of community versions of eZ publish

Current support is for Debian/Ubuntu based systems.  RedHat/CenrOs support will
be added in the future.

Basic usage
-----------
To install a system suitable for running eZ Publish

    class { 'ezpublish': }

This will setup a system suitable for running eZ publish.  A database server is
not installed allowing this option to be used for systems with a separate DB
server.

To install a standalone system: 

    class { 'ezpublish::standalone' }

This is the same as the above system but includes a database server.


To configure Apache so eZ Publish can be installed as the default application: 

    class{ 'ezpublish::default' }

To setup an eZ Publish virtual host:

    ezpublish::vhost { 'ezdemo.yourdomain.com'
    }

The [apache::vhosts] (https://github.com/puppetlabs/puppetlabs-apache)
defination is reused here with some ezpublish specific defaults.

To setup a eZ Publish database:

    ezpublish::database { 'ezpublish':
        ensure  => 'present',
        db_user => 'ezpublish',
        db_pass => 'password',
    }

To install eZ Publish:

    ezpublish::install { 'eZ Publish Community Project 2013.1':
        download_file => 'ezpublish5_community_project-2013.1-gpl-full.tar.gz',
        download_url  => 'http://share.ez.no/content/download/147668/867411/version/1/file/ezpublish5_community_project-2013.1-gpl-full.tar.gz',
        destination   => '/var/www'
    }

This will install the latest eZ Publish Community Project in the default application.

Install the latest eZ Publish Community Project
-----------------------------------------------
The above commands can be combined to prepare an eZ Publish server.

    node default {
      class { 'ezpublish::standalone': }
      class { 'ezpublish::default': }

      ezpublish::database { 'ezpublish':
        ensure  => 'present',
        db_user => 'ezpublish',
        db_pass => 'password',
      }

      ezpublish::install { 'eZ Publish Community Project 2013.1':
        download_file => 'ezpublish5_community_project-2013.1-gpl-full.tar.gz',
        download_url  => 'http://share.ez.no/content/download/147668/867411/version/1/file/ezpublish5_community_project-2013.1-gpl-full.tar.gz',
        destination   => '/var/www'
      }

    }

Dependencies
------------
Functionality is dependant on the following modules:

- [mysql] (https://github.com/puppetlabs/puppetlabs-mysql)
- [apache] (https://github.com/puppetlabs/puppetlabs-apache)
- [php] (https://github.com/example42/puppet-php)

Copyright and License
---------------------

Copyright (C) 2013 [Bruce Morrison](http://www.stuffandcontent.com/)

Bruce Morrisoncan be contacted at: bruce@stuffansdcontent.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
