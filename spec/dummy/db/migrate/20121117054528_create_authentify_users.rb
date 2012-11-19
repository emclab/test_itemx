class CreateAuthentifyUsers < ActiveRecord::Migration
  def change
    create_table :authentify_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
