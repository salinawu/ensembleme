class Comment < ActiveRecord::Base
  # attr_accessible :body, :commenter, :posting
  belongs_to :posting
end
