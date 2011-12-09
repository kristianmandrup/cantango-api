module CanTango::Macros
  module Clazz
    include CanTango::Macros::Account
    include CanTango::Macros::User
    
    def cantango options = {}
      type = case options
      when Array
        options.first
      when Symbol
        options
      when Hash
        options[:type]
      end
      # determine if user or account
      if !type
        (name =~ /.+Account$/) ? tango_account(options) : tango_user(options)
      else
        tango_account(options) and return if type.to_s == 'account'
        tango_user(options) and return if type.to_s == 'user'
        raise ArgumentError, "Unable to determine type of class to register; Please specify :user or :account as argument"
      end
    end
  end
end