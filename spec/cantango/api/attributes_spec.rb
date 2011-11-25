require 'spec_helper'
require 'helpers/current_users'

CanTango.config.users.register :user, User
CanTango.config.users.register :admin, Admin

class Context
  include CanTango::Api::User::Ability

  include CurrentUsers
  extend ::CurrentUsers
end

describe CanTango::Api::User::Ability do
  subject { Context.new }

  describe 'user_ability user' do
    specify { subject.user_ability(subject.current_user).should be_a CanTango::Ability }
  end

  describe 'user_ability admin' do
    specify { subject.user_ability(subject.current_admin).should be_a CanTango::Ability }
  end
end
 
