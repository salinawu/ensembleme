class AddLongitudeToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :longitude, :float
  end
end
