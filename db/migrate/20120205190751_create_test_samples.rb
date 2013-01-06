class CreateTestSamples < ActiveRecord::Migration
  def change
    create_table :test_itemx_test_samples do |t|
      t.integer :test_plan_id
      t.string :name
      t.string :desp
      t.integer :qty
      t.string :unit
      t.string :storage_location
      t.date :return_date
      t.text :periphral_requirement
      t.integer :manufacturer_id
      t.string :sample_doc
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
