class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.string :address
      t.string :web
      t.boolean :active, :default => true
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
