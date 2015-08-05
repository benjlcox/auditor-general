require 'rails/generators'
require 'rails/generators/active_record'

module AuditorGeneral
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      desc "Add migration for AuditorGeneral"

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def copy_migrations
        migration_template "create_auditor_general_log.rb", "db/migrate/create_auditor_general_log.rb"
      end

      def copy_model
        copy_file "auditor_general_log.rb", "app/models/auditor_general_log.rb"
      end
    end
  end
end
