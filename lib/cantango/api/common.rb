module CanTango::Api
  module Common
    def create_ability candidate, opts = {}
      ability = default_ability_class.new candidate, opts
      config.ability.factory_build ability, opts.merge(:modes => execution_modes)
    end

    def category label
      config.models.by_category label
    end
    
    protected

    def default_ability_class
      CanTango.config.ability.default_class
    end

    def execution_modes
      CanTango.config.ability.modes || [:no_cache]
    end
    
    def config
      CanTango.config
    end
  end
end

