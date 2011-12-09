module CanTango::Api
  module Session
    module User
      def self.included(base)
        ::CanTango.config.users.registered.each do |user|
          base.class_eval %{
            def session_#{user}
              current_#{user} if respond_to? :current_#{user}
              guest_user
            end
          }
        end
      end

      # give me any logged in user or the guest user
      def any_user *types
        types = types.flatten.select_labels.map(&:to_sym)
        types = types & ::CanTango.config.users.registered
        users = types.map do |type|
          meth = :"current_#{type}"
          send(meth) if respond_to?(meth) && (types.empty? || types.include?(type))
        end
        chosen_user = users.compact.first
        chosen_user || guest_user
      end

      def guest_user
        CanTango.config.guest.user
      end
      
      def active_user
        session[:active_user]
      end

      def active_user= user
        session[:active_user] = user
      end
    end
  end
end
