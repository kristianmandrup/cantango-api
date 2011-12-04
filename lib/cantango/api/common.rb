module CanTango::Api
  module Common
    include CanTango::Api::Attributes

    def create_ability candidate, opts = {}
      config.ability.factory_build candidate, opts
    end

    def category label
      config.models.by_category label
    end
    
    protected
    
    def config
      CanTango.config
    end
  end
end

