class CreateBuildings < ActiveRecord::Migration[7.1]
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :height

      t.timestamps
    end
  end
end
