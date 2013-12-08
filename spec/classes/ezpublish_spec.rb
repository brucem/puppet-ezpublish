require 'spec_helper'
describe 'ezpublish', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
                :concat_basedir         => '/dne',
           }
       end
       it { should contain_class("apache") }
       it { should contain_class("mysql::client") }
       it { should contain_class("php") }

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
