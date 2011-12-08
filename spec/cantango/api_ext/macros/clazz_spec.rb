require 'cantango/config'
require 'fixtures/models'

require 'spec_helper'

class UserAccount
  cantango
end

class AdminAccount
  cantango
end

class AdminUser
  cantango
end

class Publisher
  cantango
end


describe CanTango::Macros::Account do
  specify { CanTango.config.users.registered.should include(:publisher, :admin) }
  specify { CanTango.config.accounts.registered.should include(:user, :admin) }
end
