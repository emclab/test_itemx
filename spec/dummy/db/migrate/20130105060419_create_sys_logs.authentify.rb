# This migration comes from authentify (originally 20120527172454)
class CreateSysLogs < ActiveRecord::Migration
  def change
    create_table :authentify_sys_logs do |t|
      t.datetime :log_date
      t.integer :user_id
      t.string :user_name
      t.string :user_ip
      t.string :action_logged

    end
  end
end
