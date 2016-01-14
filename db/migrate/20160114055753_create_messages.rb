class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :body
      t.references :group

      t.timestamps null: false
    end
    add_index :messages, :group_id
  end
end
