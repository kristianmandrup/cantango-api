module CanTango::Macros
  module User
    def tango_user options = {}
      self.send :include, CanTango::Api::Model::User
    end
  end
end