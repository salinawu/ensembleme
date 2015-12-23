class Posting < ActiveRecord::Base
  validates :location, presence: true,
                    length: { minimum: 5 }
end
