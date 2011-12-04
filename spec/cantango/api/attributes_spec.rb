require 'spec_helper'

class Context
  include CanTango::Api::Attributes
end

describe CanTango::Api::Attributes do
  subject { Context.new }

  [:read, :edit].each do |action|
    describe ":#{action} attribute" do
      specify do 
        subject.send(:"#{action}_attribute", :post).should == :"#{action}_attr_post"
      end
    end

    describe ":#{action} attributes" do
      specify do 
        subject.send(:"#{action}_attributes", :post, :project).should include(:"#{action}_attr_post")
      end
    end
  end
end
 
