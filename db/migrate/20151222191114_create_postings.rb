class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string :location
      t.string :expertise
      t.string :commitment
      t.string :ensemble

      t.timestamps null: false
    end
  end
end
