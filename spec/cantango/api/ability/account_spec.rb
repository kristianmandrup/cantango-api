require 'spec_helper'

# require 'cantango/configuration/engines/store_engine_shared'

CanTango.configure do |config|
  config.users.register     :user, User
  config.users.register     :admin, Admin

  config.accounts.register  :user, UserAccount
  config.accounts.register  :admin, AdminAccount

  # config.cache_engine.set :off
  # config.permit_engine.set :on
end

class Context
  include CanTango::Api::Account::Ability

  include_and_extend ::CurrentUserAccounts
end

describe CanTango::Api::UserAccount::Ability do
  subject { Context.new }

  describe 'user_account_ability' do
    specify { subject.user_account_ability(subject.current_user_account).should be_a CanTango::Ability }
    specify { subject.user_account_ability(subject.current_admin_account).should be_a CanTango::Ability }
  end

  describe 'current_account_ability' do
    specify { subject.current_account_ability(:user).should be_a CanTango::Ability }
    specify { subject.current_account_ability(:admin).should be_a CanTango::Ability }
  end
end
