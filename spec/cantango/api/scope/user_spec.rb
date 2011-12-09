require 'spec_helper'
require 'fixtures/models'
require 'helpers/current_users'

class Context
  include CanTango::Api::Scope::User

  include_and_extend ::CurrentUsers
end

class User
  cantango
end

class Admin
  tango_user :masquerade
end

describe CanTango::Api::Scope::User do
  subject { Context.new }

  before do
    subject.current_admin.masquerade_as subject.current_user
  end

  describe 'scope_user(scope, options)' do 
    specify do
      subject.scope_user :user do |user|
        user.subject.should == subject.current_user
      end
    end
  end

  describe 'real_user(scope, options)' do
    specify do
      subject.real_user :user do |user|
        user.subject.should == subject.current_user
      end
    end
  end
end