require 'spec_helper'
require 'fixtures/models'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Scope::Account

  include_and_extend ::CurrentUserAccounts
end

class UserAccount
  tango_account
end

class AdminAccount
  tango_account :masquerade
end

describe CanTango::Api::Scope::Account do
  subject { Context.new }

  before do
    subject.current_admin_account.masquerade_as(subject.current_user_account)
  end

  describe 'registered accounts' do
    specify { CanTango.config.accounts.registered.should include(:user, :admin) }
  end

  describe 'scope_account(scope, options)' do 
    specify do
      subject.scope_account :user do |ability|
        ability.subject.should == subject.current_user_account
      end
    end
  end

  describe 'real_account(scope, options)' do
    specify do
      subject.real_account :admin do |ability|
        ability.subject.should == subject.current_admin_account
      end
    end
  end
end