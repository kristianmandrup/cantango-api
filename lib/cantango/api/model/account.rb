module CanTango::Api
  module Model
    module Account
      attr_writer :active_user, :active_account, :ability_class

      def self.included(clazz)
        CanTango.config.accounts.register_account clazz
      end

      def active_user
        return @active_user if  @active_user
        return send(:user) if respond_to? :user
        raise "No user could be found for account: #{self}"
      end

      def active_account
        @active_account || self
      end

      # from sugar-high or Active Support
      delegate :can?, :cannot?, :to => :ability

      protected
    
      include CanTango::Api::Common

      def ability opts = {}
        create_ability active_account, opts = {}
      end  
    end
  end
end