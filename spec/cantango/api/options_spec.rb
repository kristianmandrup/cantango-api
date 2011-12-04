require 'spec_helper'

class Context
  include CanTango::Api::Options
  
  def session
    {}
  end
end

describe CanTango::Api::Options do
  subject { Context.new }

  describe 'ability_options' do
    specify do 
      subject.ability_options[:session].should == {}
    end
  end

  describe 'options_list' do  
    specify { subject.options_list.should == [:session, :request, :params, :controller, :domain, :cookies] }
  end
end
