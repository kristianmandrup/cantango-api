module CanTango::Macros
  module Account
    def tango_account options = {}
      self.send :include, CanTango::Api::Model::Account
    end
  end
end
