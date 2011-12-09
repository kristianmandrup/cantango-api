require 'cantango/config'
require 'fixtures/models'

class User
  include_and_extend SimpleRoles
end

class Admin < User
end

CanTango.configure do |config|
  config.users.register     :user, User
  config.users.register     :admin, Admin
end

require 'spec_helper'
require 'helpers/current_user_accounts'

class Context
  include CanTango::Api::Ability::User

  include_and_extend ::CurrentUsers
end

describe CanTango::Api::Ability::Dsl do
  subject { Context.new }


end