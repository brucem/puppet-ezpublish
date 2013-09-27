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
       it { should include_class("ezpublish") }
       it { should include_class("ezpublish::database_server") }

   end
end
