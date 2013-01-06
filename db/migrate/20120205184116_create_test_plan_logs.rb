class CreateTestPlanLogs < ActiveRecord::Migration
  def change
    create_table :test_itemx_test_plan_logs do |t|
      t.integer :test_plan_id
      t.text :content
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
