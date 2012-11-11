class Comment < ActiveRecord::Base
  belongs_to :recurrence
  belongs_to :user

#  validates :title, :presence => true, length => { :minimum => 5 }

  attr_accessible :body, :title, :recurrence_id, :user_id
end

