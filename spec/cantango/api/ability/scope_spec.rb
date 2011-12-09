require 'cantango/config'
require 'fixtures/models'

class User
  include_and_extend SimpleRoles
end

class Admin < User
end

CanTango.configure do |config|
  config.users.register     :user, User
  config.users.register     :admin, Admin
end

require 'spec_helper'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Ability::User

  include_and_extend ::CurrentUsers
end

describe CanTango::Api::Ability::Scope do
  subject { CanTango::Api::Ability::Scope.new :user, @ability }

  describe 'attributes set on init' do
    specify { subject.name.should == :user }
    specify { subject.ability.should == @ability }
    it 'should yield the scope' do
      CanTango::Api::Ability::Scope.new(:user, @ability) do |scope|
        scope.should be_a CanTango::Api::Ability::Scope
      end
    end
  end
end