# This migration comes from rfqx_emc (originally 20121125022042)
class CreateRfqxEmcRfqStandards < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_rfq_standards do |t|
      t.integer :rfq_id
      t.integer :standard_id

      #t.timestamps
    end
  end
end
