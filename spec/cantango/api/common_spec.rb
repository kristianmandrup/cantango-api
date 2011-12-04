require 'spec_helper'
require 'fixtures/models'

class CommonContext
  include CanTango::Api::Common
end

describe CanTango::Api::Common do
  before do
    @user = User.new
  end

  subject { CommonContext.new }


  describe 'create_ability(candidate)' do
    subject.create_ability(@user).should be_a CanTango::Ability::Base
  end

  describe 'category(label)' do
    before do
      subject.config.categories.register :grains => ['Wheat', 'Barley']
    end
    
    specify { subject.category('unknown').should == nil }
    specify { subject.category('grains').should_not be_empty }
  end
end
