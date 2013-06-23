require 'spec_helper'
describe 'ezpublish', :type => :class do
    context "on a Debian OS" do
        let :facts do
            {
                :operatingsystem => 'Ubuntu',
                :operatingsystemrelease => '12.04',
                :osfamily => 'Debian',
           }
       end
        it { should include_class("apache") }
        it { should include_class("mysql") }
        it { should include_class("php") }
   end
end
