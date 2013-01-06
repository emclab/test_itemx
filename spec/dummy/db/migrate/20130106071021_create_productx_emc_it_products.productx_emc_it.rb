# This migration comes from productx_emc_it (originally 20121121014106)
class CreateProductxEmcItProducts < ActiveRecord::Migration
  def change
    create_table :productx_emc_it_products do |t|
      t.string :name
      t.string :model
      t.string :drawing_num
      t.text :tech_spec
      t.string :work_voltage
      t.string :work_current
      t.string :frequency
      t.string :internal_frequency
      t.integer :rfq_id

      t.timestamps
    end
  end
end
