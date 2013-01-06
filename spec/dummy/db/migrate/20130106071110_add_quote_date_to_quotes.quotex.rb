# This migration comes from quotex (originally 20120725195137)
class AddQuoteDateToQuotes < ActiveRecord::Migration
  def change
    add_column :quotex_quotes, :quote_date, :date
  end
end
