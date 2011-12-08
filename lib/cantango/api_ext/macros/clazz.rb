module CanTango::Macros
  module Clazz
    include CanTango::Macros::Account
    include CanTango::Macros::User
    
    def cantango type = nil
      # determine if user or account
      if !type
        (name =~ /.+Account$/) ? tango_account : tango_user
      else
        tango_account and return if type.to_s == 'account'
        tango_user and return if type.to_s == 'user'
        raise ArgumentError, "Unable to determine type of class to register; Please specify :user or :account as argument"
      end
    end
  end
end