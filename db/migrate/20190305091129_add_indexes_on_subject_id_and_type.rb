class AddIndexesOnSubjectIdAndType < ActiveRecord::Migration[6.0]
  def change
    add_index :active_flags_flags, [:subject_id, :subject_type]
  end
end
