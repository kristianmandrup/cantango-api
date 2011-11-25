require 'spec_helper'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

describe CanTango::Api do
  subject { CanTango::Api }

  specify { subject.methods.should include(:current_user_ability) }
end
