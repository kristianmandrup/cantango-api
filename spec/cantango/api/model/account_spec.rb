require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.users.register     :user,  User
  config.users.register     :admin, Admin

  config.accounts.register  :user,  UserAccount
  config.accounts.register  :admin, AdminAccount
end

require 'spec_helper'

class UserAccount
  tango_account
end

class AdminAccount
  tango_account
end

class Context
  include CanTango::Api::Model::Account
end

describe CanTango::Api::Model::Account do
  subject { Context.new }

  specify do
    CanTango.config.accounts.registered.should include(:admin, :user)
  end

  describe 'Model API included' do
    [:active_user, :can?, :cannot?].each do |name|
      specify { subject.should respond_to name }
    end
  end
end