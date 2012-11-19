class CreateTestItemxTestItems < ActiveRecord::Migration
  def change
    create_table :test_itemx_test_items do |t|
      t.string :name
      t.string :short_name
      t.text :description
      t.integer :standard_id
      t.decimal :rate,  :precision => 8, :scale => 2
      t.boolean :active, :default => true
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
