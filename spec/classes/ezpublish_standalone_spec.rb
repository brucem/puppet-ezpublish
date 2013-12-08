require 'spec_helper'
describe 'ezpublish::standalone', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
                :concat_basedir         => '/dne',
           }
       end
       it { should contain_class("ezpublish") }
       it { should contain_class("ezpublish::database_server") }

   end
end
