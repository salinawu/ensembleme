class RemoveCommitmentFromPostings < ActiveRecord::Migration
  def change
    remove_column :postings, :commitment, :string
  end
end
