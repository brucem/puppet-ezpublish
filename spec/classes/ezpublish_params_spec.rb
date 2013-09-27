require 'spec_helper'
describe 'ezpublish::params', :type => :class do
    context "on a Debian based OS" do
        let :facts do
            {
                :osfamily               => 'Debian',
                :operatingsystemrelease => '6',
                :concat_basedir         => '/dne',
           }
       end
      it { should contain_ezpublish__params }
      # There are 4 resources in this class currently
      # there should not be any more resources because it is a params class
      # The resources are class[apache::params], class[main], class[settings], stage[main]
      it "Should not contain any resources" do
        subject.resources.size.should == 4
      end
   end
end
