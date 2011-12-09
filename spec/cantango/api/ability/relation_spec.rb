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

module CanTango::Ability
  class Base
    def user
      candidate
    end

    def account
      candidate
    end
  end
end

class Context
  include CanTango::Api::Ability::User

  include_and_extend ::CurrentUsers
end

describe CanTango::Api::Ability::Relation do
  before do
    @user = User.new 'krisy', 'krisy@gmail.com'
    @ability = CanTango::Ability::Base.new @user
    @scope = CanTango::Api::Ability::Scope.new :user, @ability
  end
  
  it 'should raise MissingRelation error when no ownership relation on model' do
    lambda { 
      CanTango::Api::Ability::Relation.new :owner, @ability, @scope, Post 
    }.should raise_error(CanTango::Api::Ability::MissingRelationError)
  end

  it 'should NOT raise MissingRelation error when there is the ownership relation on the model' do
    lambda { CanTango::Api::Ability::Relation.new :owner, @ability, @scope, Project }.should_not raise_error
  end

  subject { CanTango::Api::Ability::Relation.new :owner, @ability, @scope, Project }

  describe 'Relation.new attribute, ability, scope, *models, &block'  do 
    specify { subject.attribute.should == :owner }
    specify { subject.abil.should == @ability }
    specify { subject.scope.should == @scope }
    specify { subject.models.should include Project }
  end
  
  #   describe 'owner_of(model)' do
  #     describe 'can' do
  #       before do
  #         subject.owner_of(Post).can(:edit)
  #       end
  #       specify { subject.can?(:edit, Post).should be_true }
  #     end
  # 
  #     describe 'cannot' do
  #       before do
  #         subject.owner_of(Post).can(:edit)
  #       end
  #       specify { subject.can?(:edit, Post).should be_true }
  #     end
  # 
  #     describe 'block' do
  #       before do
  #         subject.owner_of(Post) do |owner|
  #           owner.can(:edit)
  #           owner.cannot(:publish)
  #         end
  #       end
  #       specify { subject.can?(:edit, Post).should be_true }
  #       specify { subject.can?(:publish, Post).should be_false }
  #       specify { subject.cannot?(:publish, Post).should be_true }
  #     end
  #   end
  # end  
end