module CanTango::Api
  module Account
    def self.included base
      apis.each do |api|
        base.send :include, clazz(api)
      end
    end

    def self.apis
      [:ability, :can, :scope, :session]
    end

    def self.clazz api
      "CanTango::Api::#{api.to_s.camelize}::Account".constantize
    end
  end
end

