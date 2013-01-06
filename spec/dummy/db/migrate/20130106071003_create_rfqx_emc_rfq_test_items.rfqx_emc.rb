# This migration comes from rfqx_emc (originally 20121125022947)
class CreateRfqxEmcRfqTestItems < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_rfq_test_items do |t|
      t.integer :rfq_id
      t.integer :test_item_id

      #t.timestamps
    end
  end
end
