class Posting < ActiveRecord::Base
  validates :location, presence: true,
                    length: { minimum: 5 }
  # default_scope -> { order(created_at: :desc) }
  belongs_to :user
  validates :user_id, presence: true
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?
end
