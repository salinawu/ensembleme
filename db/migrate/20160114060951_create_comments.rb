class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :posting

      t.timestamps null: false
    end
    add_index :comments, :posting_id
  end
end
