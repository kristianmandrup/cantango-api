module CanTango
  module Macros
    sweet_scope :ns => {:CanTango => 'cantango/api_ext'} do
      autoload_modules :Account, :User, :Clazz
    end
  end
end

class Class
  include CanTango::Macros::Clazz
end
  