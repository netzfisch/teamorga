class Participation < ActiveRecord::Base
  attr_accessible :recurrence, :user, :status

  validates_presence_of :recurrence, :user

  belongs_to :recurrence, :include => :event
  belongs_to :user

  scope :accepted, where(status: true)
  scope :refused, where(status: false)

  #def self.feedback(recurrence, status)
  #  where("recurrence_id = ? AND status = ? ", recurrence.id, status).map(&:user)
  #end
end
