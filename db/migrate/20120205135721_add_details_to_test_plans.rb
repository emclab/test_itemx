class AddDetailsToTestPlans < ActiveRecord::Migration
  def change
    add_column :test_itemx_test_plans, :sample_requirement, :text
    add_column :test_itemx_test_plans, :sample_qty, :integer
    add_column :test_itemx_test_plans, :unit, :string
  end
end
