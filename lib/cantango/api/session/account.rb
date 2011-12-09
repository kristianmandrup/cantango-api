module CanTango::Api
  module Session
    module Account
      def self.included(base)
        ::CanTango.config.accounts.registered.each do |type|
          base.class_eval %{
            def session_#{type}_account
              current_#{type}_account if respond_to? :current_#{type}_account
              guest_account
            end
          }
        end
      end

      # give me any logged in user or the guest user
      def any_account *types
        types = types.flatten.select_labels.map(&:to_sym)
        types = types & ::CanTango.config.accounts.registered
        accounts = types.map do |type|
          meth = :"current_#{type}_account"
          send(meth) if respond_to?(meth) && (types.empty? || types.include?(type))
        end
        chosen_account = accounts.compact.first
        chosen_account || guest_account
      end

      def guest_account
        CanTango.config.guest.account
      end
      
      def active_account
        session[:active_account]
      end

      def active_account= account
        session[:active_account] = account
      end
    end
  end
end
