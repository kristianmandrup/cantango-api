require 'spec_helper'
require 'cantango/api/ability/dsl/relationship_ex'

class User
  cantango
end

module CanTango::Ability
  class Base
    include CanTango::Api::Ability::Dsl::Relationship

    def user
      candidate
    end

    def account
      candidate
    end
  end
end

describe CanTango::Api::Ability::Dsl::Relationship do
  it_should_behave_like 'CanTango::Api::Ability::Dsl::Relationship' do
    before do
      @user = User.new 'krisy', 'krisy@gmail.com'
    end
    subject { CanTango::Ability::Base.new @user }
  end
end