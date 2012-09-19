class Participation < ActiveRecord::Base
  belongs_to :recurrence
  belongs_to :user
  
  attr_accessible :recurrence_id, :user_id
end
