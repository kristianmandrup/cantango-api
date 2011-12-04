module CanTango
  module Macros
    sweet_scope :ns => {:CanTango => 'cantango/api_ext'} do
      autoload_modules :Account, :User
    end
  end
end