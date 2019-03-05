class CreateActiveFlagsFlags < ActiveRecord::Migration[6.0]
  def change
    create_table :active_flags_flags do |t|
      t.string :key
      t.string :value
      t.integer :subject_id
      t.string :subject_type

      t.timestamps
    end
  end
end
