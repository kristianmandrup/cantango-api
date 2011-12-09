module CanTango::Api::Ability
  class Scope
    include CanTango::Api::Ability::Dsl::Relationship
    
    attr_reader :name, :ability

    def initialize name, ability, &block
      @name = name.to_sym
      @ability = ability
      yield self if block
    end
  end
end
