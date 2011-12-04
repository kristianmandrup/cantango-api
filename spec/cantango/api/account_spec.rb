require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.accounts.register :user, UserAccount
end

require 'spec_helper'

class AccountContext
  include CanTango::Api::Account
end

describe CanTango::Api::Account do
  subject { AccountContext.new }

  describe 'Ability API included' do
    [:account_ability, :current_account_ability].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Can API included' do
    [:user_account_can?, :user_account_cannot?].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Scope API included' do
    [:scope_account, :account_scope, :real_account].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Session API included' do
    [:any_account, :active_account, :active_account=].each do |name|
      specify { subject.should respond_to name }
    end
  end
end