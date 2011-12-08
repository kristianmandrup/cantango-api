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

class AdminUser
  cantango
end

describe CanTango::Api::Scope::User do
  subject { Context.new }

  before do
    subject.current_user.active_account = subject.current_admin
  end

  describe 'scope_user(scope, options)' do 
    specify do
      subject.scope_user :user do |user|
        user.candidate.should == subject.current_admin
      end
    end
  end

  describe 'real_user(scope, options)' do
    specify do
      subject.real_user :user do |user|
        user.candidate.should == subject.current_user
      end
    end
  end
end