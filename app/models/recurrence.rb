class Recurrence < ActiveRecord::Base
  attr_accessible :scheduled_to, :user_id, :user_ids

  validates_presence_of :scheduled_to

  belongs_to :event
  has_many :participations, :include => :user, :dependent => :destroy
  has_many :users, :through => :participations
  has_many :comments, :dependent => :nullify

  default_scope joins(:event).order("scheduled_to ASC, events.base_time ASC")
  scope :current, lambda { where("scheduled_to >= ?", Time.zone.today) }

  def feedback(status)
    case
    when status == true
      self.participations.accepted.map(&:user)
      #users.where("recurrence_id = ? AND status = ? ", self.id, true)
    when status == false
      self.participations.refused.map(&:user)
      #users.where("recurrence_id = ? AND status = ? ", self.id, false)
    when status == "none"
      User.licence - feedback(true) - feedback(false)
    end
  end
end
