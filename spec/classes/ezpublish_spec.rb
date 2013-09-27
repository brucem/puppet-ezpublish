require 'spec_helper'
describe 'ezpublish', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
           }
       end
       it { should include_class("apache") }
       it { should include_class("mysql") }
       it { should include_class("php") }

       ['mysql', 'gd', 'mcrypt', 'imagick', 'curl', 'xsl', 'intl'].each do |phpmodulename|
         it { should contain_php__module(phpmodulename) }
       end

       ['apc'].each do |pearmodulename|
         it { should contain_php__pear__module(pearmodulename) }
       end

       ['imagemagick'].each do |packagename|
         it { should contain_package(packagename)}
       end

   end
end
