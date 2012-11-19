class CreateTestItemxStandards < ActiveRecord::Migration
  def change
    create_table :test_itemx_standards do |t|
      t.string :name
      t.text :description
      t.boolean :active, :default => true
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
