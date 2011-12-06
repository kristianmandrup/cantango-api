module CanTango::Macros
  module Account
    def tango_account options = {}
      self.send :include, CanTango::Api::Model::Account
    end
    alias_method :cantango_account, :tango_account
  end
end
