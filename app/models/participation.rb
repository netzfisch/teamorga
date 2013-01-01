class Participation < ActiveRecord::Base

  validates_presence_of :recurrence, :user

  belongs_to :recurrence, :include => :event
  belongs_to :user

  attr_accessible :recurrence, :user, :status

  scope :accepted, where(status: true)
  scope :refused, where(status: false)

end

