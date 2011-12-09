module CanTango::Api::Ability::Dsl
  module Relationship
    def self.included(base)
      ::CanTango.config.user.relations.each do |relationship|
        base.class_eval %{
          def #{relationship}_of *models, &block
            options = models.extract_options!
            scope = options[:scope] || :user
            relation = Relation.new :#{relationship}, self, scope, *models, &block
            yield relation if block
            relation
          end
        }
      end
    end
  end
end