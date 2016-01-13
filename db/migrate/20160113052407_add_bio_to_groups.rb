class AddBioToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :bio, :text
  end
end
