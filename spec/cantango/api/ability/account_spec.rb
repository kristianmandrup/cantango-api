require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.users.register     :user, User
  config.users.register     :admin, Admin

  config.accounts.register  :user, UserAccount
  config.accounts.register  :admin, AdminAccount
end

require 'spec_helper'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Ability::Account

  include_and_extend ::CurrentUserAccounts
end

describe CanTango::Api::Ability::Account do
  subject { Context.new }

  describe 'account_ability' do
    specify { subject.account_ability(subject.current_user_account).should be_a CanTango::Ability::Executor }
    specify { subject.account_ability(subject.current_admin_account).should be_a CanTango::Ability::Executor }
  end

  describe 'current_account_ability' do
    specify { subject.current_account_ability(:user).should be_a CanTango::Ability::Executor }
    specify { subject.current_account_ability(:admin).should be_a CanTango::Ability::Executor }
  end
end
