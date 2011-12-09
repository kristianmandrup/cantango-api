require 'active_support/inflector'

module CanTango::Api::Ability
  class MissingRelationError < StandardError; end  
  
  class Relation
    attr_reader :attribute, :abil, :scope, :models

    include CanTango::Adaptor
    include CanTango::CanCan::RuleClass

    def initialize attribute, ability, scope, *models, &block
      @attribute = attribute
      @abil = ability
      @scope = scope
      @models = models

      check_models
      use_adaptor! self, user_scope
    end

    def can(action)
      models.each do |model|
        rules << rule_class.new(true, action, model, nil, condition_block(model))
      end
    end

    def cannot(action)
      models.each do |model|
        rules << rule_class.new(false, action, model, nil, condition_block(model))
      end
    end

    protected

    def condition_block model
      return attribute_condition(attribute, user_scope) if model.new.respond_to?(attribute)
      return include_condition(plural_attribute, user_scope) if model.new.respond_to?(plural_attribute)
    end

    def user_scope
      @user_scope ||= (scope == :account) ? ability.account : ability.user
    end

    def scope_key
      @scope_key ||= (scope == :account) ? :user_account : :user
    end

    def ability
      abil.respond_to?(:ability) ? abil.ability : abil
    end

    def rules
      ability.send :rules
    end

    def plural_attribute
      :"#{attribute.to_s.pluralize}"
    end

    def check_models
      models.each do |model|
        raise MissingRelationError, "#{model} has no :#{attribute} or :#{plural_attribute} defined" if !model.new.respond_to?(attribute) && !model.new.respond_to?(plural_attribute)
      end
    end
  end
end

