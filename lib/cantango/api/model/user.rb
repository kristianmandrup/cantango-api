module CanTango::Api
  module Model
    module User
      attr_writer :active_user, :active_account, :ability_class

      def self.included(clazz)
        CanTango.config.users.register_user clazz
      end

      def active_user
        @active_user || self
      end

      def active_account
        return @active_account if  @active_account
        return send(:account) if respond_to? :account
        raise "No account could be found for user: #{self}"
      end

      # from sugar-high or Active Support
      delegate :can?, :cannot?, :to => :ability

      protected

      include CanTango::Api::Common

      def ability opts = {}
        create_ability active_user, opts = {}
      end  
    end
  end
end