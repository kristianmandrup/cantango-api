require 'spec_helper'
require 'fixtures/models'
require 'cantango/api/ability/dsl/relationship_ex'

class User
  cantango
end

module CanTango::Ability
  class Base
    include CanTango::Api::Ability::Dsl

    def user
      candidate
    end

    def account
      candidate
    end
  end
end

describe CanTango::Api::Ability::Dsl do
  before do
    @user = User.new 'krisy', 'krisy@gmail.com'
  end
  subject { CanTango::Ability::Base.new @user }

  it_should_behave_like 'CanTango::Api::Ability::Dsl::Relationship'
  
  describe 'scope name, &block' do
    specify do
      subject.scope :user do |scope|
        scope.should be_a CanTango::Api::Ability::Scope
      end
    end
  end
end