require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.users.register     :user,  User
  config.users.register     :admin, Admin

  config.accounts.register  :user,  UserAccount
  config.accounts.register  :admin, AdminAccount
  
  config.modes.register     :no_cache, CanTango::Ability::Mode::NoCache
  config.ability.mode = :no_cache
end

require 'spec_helper'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Can::User

  include_and_extend ::CurrentUserAccounts
end

module CanTango::Ability::Mode
  class NoCache
    def calculate_rules
      can :edit, Article
      cannot :edit, User
    end
  end
end

describe CanTango::Api::Can::Account do
  subject { Context.new }

  describe 'user_account' do
    specify do
      subject.current_user_ability(:user).should be_a CanTango::Ability::Executor::Modal
    end

    specify do
      subject.current_user_ability(:user).modes.should == [:no_cache]
    end

    specify do
      subject.current_user_ability(:user).should respond_to(:can?)
    end

    specify do
      subject.current_user_ability(:user).rules.should_not be_empty
    end

    specify do
      subject.current_user_ability(:user).can?(:edit, Article).should be_true
    end
    
    specify do
      CanTango.config.users.registered.should include(:user)
    end    
    
    # user can edit Article, not Admin
    specify do
      subject.user_can?(:edit, Article).should be_true
      subject.user_can?(:edit, User).should be_false

      subject.user_cannot?(:edit, User).should be_true
      subject.user_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin_user' do
    specify do
      CanTango.config.users.registered.should include(:admin)
    end

    specify do
      subject.admin_can?(:edit, Article).should be_true
      subject.admin_can?(:edit, User).should be_false

      subject.admin_cannot?(:edit, User).should be_true
      subject.admin_cannot?(:edit, Article).should be_false
    end
  end
end


