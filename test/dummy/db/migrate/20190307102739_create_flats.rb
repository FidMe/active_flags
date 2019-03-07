class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :name
      t.text :description
    end
  end
end
