require 'cantango/config'
require 'fixtures/models'

require 'spec_helper'

class Context
  include CanTango::Api::Model::User
end

class User
  tango_user
end

class Editor
  tango_user
end

class BadUser
  tango_user
end


describe CanTango::Api::Model::User do
  subject { Context.new }

  specify do
    CanTango.config.users.registered.should include(:editor, :user, :bad)
  end

  describe 'Model API included' do
    [:active_user, :can?, :cannot?].each do |name|
      specify { subject.should respond_to name }
    end
  end
end