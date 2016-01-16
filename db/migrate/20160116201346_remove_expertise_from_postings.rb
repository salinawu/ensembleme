class RemoveExpertiseFromPostings < ActiveRecord::Migration
  def change
    remove_column :postings, :expertise, :string
  end
end
