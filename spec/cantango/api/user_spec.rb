require 'cantango/config'
require 'fixtures/models'

CanTango.configure do |config|
  config.users.register :user, User
end

require 'spec_helper'

class UserContext
  include CanTango::Api::User
end

describe CanTango::Api::User do
  subject { UserContext.new }

  describe 'Ability API included' do
    [:user_ability, :current_user_ability].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Can API included' do
    [:user_can?, :user_cannot?].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Scope API included' do
    [:scope_user, :user_scope, :real_user].each do |name|
      specify { subject.should respond_to name }
    end
  end

  describe 'Session API included' do
    [:any_user, :active_user, :active_user=].each do |name|
      specify { subject.should respond_to name }
    end
  end
end