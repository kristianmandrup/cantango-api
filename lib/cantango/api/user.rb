module CanTango::Api
  module User
    def self.included base
      apis.each do |api|
        base.send :include, clazz(api)
      end
    end

    def self.apis
      [:ability, :can, :scope, :session]
    end

    def self.clazz api
      "CanTango::Api::#{api.to_s.camelize}::User".constantize
    end
  end
end
