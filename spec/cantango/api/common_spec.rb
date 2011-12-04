require 'spec_helper'
require 'fixtures/models'

class CommonContext
  include CanTango::Api::Common
end

class Wheat
end

class Barley
end

describe CanTango::Api::Common do
  before do
    @user = User.new 'kris', 'kris@mail.ru'
  end

  subject { CommonContext.new }

  describe 'create_ability(candidate)' do
    specify do
      subject.create_ability(@user).should be_a CanTango::Ability::Executor
    end
  end

  describe 'category(label)' do
    before do
      CanTango.config.categories.register :grains => ['Wheat', 'Barley']
    end
    
    specify do
      lambda { subject.category('unknown') }.should raise_error
    end
    specify { subject.category('grains').should_not be_empty }
  end
end
