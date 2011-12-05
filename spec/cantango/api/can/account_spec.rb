require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.users.register     :user,  User
  config.users.register     :admin, Admin

  config.accounts.register  :user,  UserAccount
  config.accounts.register  :admin, AdminAccount
end

require 'spec_helper'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Can::Account

  include_and_extend ::CurrentUserAccounts
end

describe CanTango::Api::Can::Account do
  subject { Context.new }

  describe 'user_account' do
    # user can edit Article, not Admin
    specify do
      subject.user_account_can?(:edit, Article).should be_true
      subject.user_account_can?(:edit, User).should be_false

      subject.user_account_cannot?(:edit, User).should be_true
      subject.user_account_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin_account' do
    specify do
      subject.admin_account_can?(:edit, Article).should be_true
      subject.admin_account_can?(:edit, User).should be_false

      subject.admin_account_cannot?(:edit, User).should be_true
      subject.admin_account_cannot?(:edit, Article).should be_false
    end
  end
end


