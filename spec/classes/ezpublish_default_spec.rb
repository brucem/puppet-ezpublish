require 'spec_helper'
describe 'ezpublish::default', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily => 'Debian',
           }
       end
       it { should include_class("ezpublish") }
       it { should contain_file("/var/www/") }
       it { should contain_file("/var/www/index.html").with_ensure('absent') }
       it { should contain_file("/etc/apache2/conf.d/ezpublish") }
   end
end
