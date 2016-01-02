class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string :location
      t.string :expertise
      t.string :commitment
      t.string :ensemble

      # t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    # add_index :postings, [:user_id, :created_at]
  end
end
