module CanTango::Api::Ability
  module Dsl
    sweetload :Relationship
    
    include Relationship

    # creates a scope that enforces either using the user or user_account 
    # for determining relationship matches on the models
    def scope name, &block
      yield Scope.new name, self, &block
    end
  end
end

