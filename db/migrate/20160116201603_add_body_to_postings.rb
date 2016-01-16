class AddBodyToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :body, :text
  end
end
