class Message < ActiveRecord::Base
  # attr_accessible :body, :commenter, :post
  belongs_to :group
end
