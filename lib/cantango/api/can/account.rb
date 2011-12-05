module CanTango::Api
  module Can
    module Account
      include CanTango::Api::Ability::Account
      # Example: generated from types of accounts! (see below)
      # def admin_account_can?(*args)
      #   current_account_ability(:admin).can?(*args)
      # end
      def self.included(base)
        ::CanTango.config.accounts.registered.each do |account|

          # by default alias call to current_xxx_account to current_xxx (devise user method) unless already defined!
          unless base.methods.include? :"current_#{account}_account"
            define_method :"current_#{account}_account" do
              send :"current_#{account}"
            end
          end

          base.class_eval %{
            def #{account}_account_can? *args
              current_account_ability(:#{account}).can?(*args)
            end

            def #{account}_account_cannot? *args
              current_account_ability(:#{account}).cannot?(*args)
            end
           }
        end
      end
    end
  end
end
