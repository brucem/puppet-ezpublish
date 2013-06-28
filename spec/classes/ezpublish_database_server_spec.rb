require 'spec_helper'
describe 'ezpublish::database_server', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily => 'Debian',
           }
       end
       it { should include_class("mysql::server") }
   end
end
