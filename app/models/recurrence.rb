class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :destroy
  has_many :users, :through => :participations
  has_many :comments, :dependent => :nullify

  validates_presence_of :scheduled_to

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :user_id, :user_ids

  default_scope joins(:event).order("scheduled_to ASC, events.base_time ASC")
  scope :current, lambda { where("scheduled_to >= ?", Time.zone.today) }

  def feedback(status)
    users.where("recurrence_id = ? AND status = ? ", self.id, status)
#    case
#    when status == "true"
#      recurrence.participations.accepted
#    when status == "false"
#      recurrence.participations.refused
#    when status == "none"
#      User.licence - recurrence.participations.accepted - recurrence.participations.refused
#    end
  end

  def no_feedback
    User.licence - feedback(true) - feedback(false)
  end

end

