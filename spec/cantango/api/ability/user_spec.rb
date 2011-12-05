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

describe CanTango::Api::Ability::User do
  subject { Context.new }

  describe 'user_ability user' do
    specify { subject.user_ability(subject.current_user).should be_a CanTango::Ability::Executor }
  end

  describe 'user_ability admin' do
    specify { subject.user_ability(subject.current_admin).should be_a CanTango::Ability::Executor }
  end

  describe 'current_user_ability :user' do
    specify { subject.current_user_ability(:user).should be_a CanTango::Ability::Executor }

    # it 'should set the :user user correctly on ability' do
    #   subject.current_user_ability(:user).user.should == subject.current_user
    # end
  end

  describe 'current_user_ability :admin' do
    specify { subject.current_user_ability(:admin).should be_a CanTango::Ability::Executor }

    # it 'should set the :admin user correctly on ability' do
    #   subject.current_user_ability(:admin).user.should == subject.current_admin
    # end
  end
end


