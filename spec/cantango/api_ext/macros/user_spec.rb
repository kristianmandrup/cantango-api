require 'cantango/config'
require 'fixtures/models'

require 'spec_helper'

class User
  tango_user
end

class EditorUser
  tango_user
end

describe CanTango::Macros::User do
  specify { CanTango.config.users.registered.should include(:user, :editor) }
end
  