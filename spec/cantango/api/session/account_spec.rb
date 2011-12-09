require 'spec_helper'
require 'fixtures/models'
require 'helpers/current_user_accounts'

class SessionContext
  include Singleton
  include CanTango::Api::Session::Account

  include_and_extend ::CurrentUserAccounts
  
  attr_writer :session
  def session
    @session ||= {}
  end
end

# mock
module CanTango::Api
  module Session
    module Account
      def guest_account
        SessionContext.instance.current_guest_account
      end
    end
  end
end

class UserAccount
  tango_account
end

class AdminAccount
  tango_account
end

describe CanTango::Api::Session::Account do
  subject { SessionContext.instance }

  describe 'registered accounts' do
    specify { CanTango.config.accounts.registered.should include(:user, :admin) }
  end

  describe 'any_account' do
    describe 'default to :guest if none found' do
      specify do 
        subject.any_account(:unknown).should == subject.guest_account
      end
    end

    describe 'find :admin' do
      specify do 
        subject.any_account(:admin, :user).should == subject.current_admin_account
      end
    end
  end
  
  describe 'guest_account' do
    specify do 
      subject.guest_account.role?(:guest).should be_true
    end    
  end

  describe 'active_account' do
    specify do 
      subject.active_account.should == nil
    end    
  end

  describe 'active_account=' do
    specify do 
      subject.active_account = subject.current_admin_account
      subject.active_account.should == subject.current_admin_account
    end    
  end
end