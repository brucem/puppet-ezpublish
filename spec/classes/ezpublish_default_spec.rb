require 'spec_helper'
describe 'ezpublish::default', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
            }
        end
        it { should include_class("ezpublish") }
        it { should contain_ezpublish__vhost("default") }
    end
end
