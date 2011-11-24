require 'rspec'
require 'cantango/api'

describe 'cantango/api' do
  specify do 
    lambda { CanTango::Api }.should_not raise_error
  end
end
