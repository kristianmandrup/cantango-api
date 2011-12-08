require 'cantango/config'
require 'fixtures/models'

require 'spec_helper'

class UserAccount
  tango_account
end

class AdminAccount
  cantango_account
end

describe CanTango::Macros::Account do
  specify { CanTango.config.accounts.registered.should include(:user, :admin) }
end
