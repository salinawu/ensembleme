class CreateUsersGroupsJoin < ActiveRecord::Migration
  # def change
  #   create_table :users_groups_joins do |t|
  #   end
  # end

  def self.up
    create_table 'groups_users', :id=>false do |t|
      t.column 'group_id', :integer
      t.column 'user_id', :integer
    end
  end

  def self.down
    drop_table 'groups_users'
  end
end
