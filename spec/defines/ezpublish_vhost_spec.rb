require 'spec_helper'
describe 'ezpublish::vhost', :type => :define do
    let :pre_condition do
    'class { "ezpublish": }'
    end
    let :title do
      'test.vhost.com'
    end
    let :default_params do
        {
            :install_dir => '/rspec/docroot',
        }
    end

    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
                :concat_basedir         => '/dne',
            }
        end
        it { should contain_class('ezpublish') }
        it { should contain_apache__vhost('test.vhost.com') }

    end
end
