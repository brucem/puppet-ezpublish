require 'spec_helper'
describe 'ezpublish::vhost', :type => :define do
  let :title do
      'test.vhost.com'
  end

  context "on a Debian based OS" do
    let :facts do
      {
        :osfamily => 'Debian',
      }
    end
    it { should contain_class('ezpublish') }
    it { should contain_apache__vhost('test.vhost.com') }

  end
end
