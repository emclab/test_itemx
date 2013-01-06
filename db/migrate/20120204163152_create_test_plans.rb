class CreateTestPlans < ActiveRecord::Migration
  def change
    create_table :test_itemx_test_plans do |t|
      t.integer :quote_id
      t.date :start_date
      t.date :finish_date
      t.boolean :cancelled, :default => false
      t.boolean :completed, :default => false
      t.date :actual_start_date
      t.date :actual_finish_date
      t.boolean :approved_by_dept_head
      t.date :approve_date_dept_head
      t.integer :dept_head_id
      t.string :reason_for_reject
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
