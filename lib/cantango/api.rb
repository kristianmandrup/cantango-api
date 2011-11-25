require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'sweetloader'

AutoLoader.namespaces = {:CanTango => 'cantango'}

module CanTango
  module Api
    autoload_modules :Ability, :Account, :Attributes, :Can
    autoload_modules :Common, :Options, :Model, :Scope, :Session, :User

    def self.apis
      [:ability, :can, :scope, :session]
    end

    apis.each do |api|
      clazz = api.to_s.camelize
      self.extend "CanTango::Api::#{clazz}::User".constantize
      self.extend "CanTango::Api::#{clazz}::Account".constantize
    end
    
    # FIX - sweetloader, camelize there!
    autoload_modules *apis.map{|api| api.to_s.camelize}
  end
end
