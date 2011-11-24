module CanTango
  module Api
    autoload_modules :Attributes, :Common, :Options, :User, :Account, :Model

    def self.apis
      [:ability, :can, :scope, :session]
    end

    apis.each do |api|
      clazz = api.to_s.camelize
      self.extend "CanTango::Api::#{clazz}::User".constantize
      self.extend "CanTango::Api::#{clazz}::Account".constantize
    end
    
    autoload_modules *apis
  end
end
