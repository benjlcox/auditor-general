class CreateAuditorGeneralLog < ActiveRecord::Migration
  def change
    create_table :auditor_general_logs do |t|

      t.string :model_type
      t.integer :model_id
      t.string :action
      t.text :alterations
      t.text :message
      t.string :origin, index: true
      t.timestamps null: false
    end

    add_index(:auditor_general_logs, [:model_type, :model_id])
  end
end
