class Participation < ActiveRecord::Base
  belongs_to :recurrence, :include => :event
  belongs_to :user

  attr_accessible :recurrence_id, :user_id
end

