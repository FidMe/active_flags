class CreateActiveFlagsFlags < ActiveRecord::Migration[6.0]
  def change
    create_table :active_flags_flags do |t|
      t.string :key
      t.string :value
      t.references :subject_id, foreign_key: true, null: false
      t.string :subject_type, null: false

      t.timestamps
    end
    add_index :active_flags_flags, [:subject_id, :subject_type]
  end
end
