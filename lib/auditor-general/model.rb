module AuditorGeneral
  module Model
    extend ActiveSupport::Concern

    included do
      class_attribute :auditable_attributes, instance_writer: false
      class_attribute :audit_create, instance_writer: false
      class_attribute :audit_destroy, instance_writer: false

      after_create :log_create
      after_update :log_update
      after_destroy :log_destroy
    end

    module ClassMethods
      def auditable(options = {})
        self.auditable_attributes = options.fetch(:attributes, [])
        self.audit_create = options.fetch(:create, true)
        self.audit_destroy = options.fetch(:destroy, true)
      end
    end

    private

    def log_create
      log_action("create") if self.audit_create
    end

    def log_update
      log_action("update") if should_log?(self.changes.keys)
    end

    def log_destroy
      log_action("destroy") if self.audit_destroy
    end

    def log_action(type)
      AuditorGeneral.log(
        model_type: self.model_name.human,
        model_id: self.id,
        action: type,
        alterations: self.destroyed? ? self.attributes : relevant_changes(self.changes),
      )
    end

    def relevant_changes(changes)
      changes.delete("updated_at")
      changes
    end

    def should_log?(attributes)
      (attributes.map(&:to_sym) & self.auditable_attributes).any?
    end
  end
end
