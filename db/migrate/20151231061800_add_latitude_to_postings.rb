class AddLatitudeToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :latitude, :float
  end
end
