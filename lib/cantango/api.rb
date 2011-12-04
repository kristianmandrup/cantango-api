require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'sweetloader'

SweetLoader.namespaces = {:CanTango => 'cantango'}
SweetLoader.mode = :require

module CanTango
  module Api
    autoload_modules :Attributes, :Options, :Common, :Ability, :Account, :Can
    autoload_modules :Model, :Scope, :Session, :User

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

require 'cantango/api_ext'