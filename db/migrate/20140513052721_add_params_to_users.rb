class AddParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :params, :text
  end
end
