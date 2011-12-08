module CanTango::Api
  module Scope
    module Account
      include CanTango::Api::Ability::Account
      
      def scope_account scope, options = {}, &block
        account = scoped_account(scope)
        ab_scope = account_ability_scope(account, options.merge(:masquerade => true))
        yield ab_scope if block
        ab_scope
      end
      alias_method :account_scope, :scope_account

      def real_account scope, options = {}, &block
        scope_account scope, options.merge(:masquerade => false), &block
      end

      protected

      def account_ability_scope account, options = {}
        CanTango::Scope::Ability.new account_ability(account, options)
      end

      def scoped_account scope
        send(:"current_#{scope}_account")
      end
    end
  end
end
