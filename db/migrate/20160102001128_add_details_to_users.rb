class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :instrument, :string
    add_column :users, :expertise, :string
    add_column :users, :commitment, :string
  end
end
