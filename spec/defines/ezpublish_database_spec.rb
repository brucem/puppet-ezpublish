require 'spec_helper'
describe 'ezpublish::database', :type => :define do
  let :title do
      'name'
  end
  let :default_params do
    {
      :db_user => 'user',
      :db_pass => 'pass',
      :db_host => 'localhost',
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
    let :params do default_params end

    it { should contain_database_user('user@localhost') }
    it { should contain_database_grant('user@localhost/name') }
    it { should contain_database('name') }

  end
end
