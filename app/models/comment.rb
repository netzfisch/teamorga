class Comment < ActiveRecord::Base
  attr_accessible :body, :title, :recurrence_id, :user_id

#  validates :title, :presence => true, length => { :minimum => 5 } #TODO remove this field!

  belongs_to :recurrence
  belongs_to :user

  default_scope order("created_at DESC")
end
