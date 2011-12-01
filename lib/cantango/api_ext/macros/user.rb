module CanTango::Macros
  module User
    def tango_user options = {}
      self.send :include, CanTango::UserApi
    end
    alias_method :cantango_user, :tango_user
  end
end