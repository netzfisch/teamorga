class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations
  has_many :comments

  validates_presence_of :scheduled_to

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids

  default_scope joins(:event).order("scheduled_to ASC, events.base_time ASC")
  scope :current, lambda { where("scheduled_to >= ?", Time.zone.today) }

  #def feedback(recurrence, status)
  #  recurrence.users.where("recurrence_id = ? AND status = ? ", recurrence.id, status)
  #end

  def with_no_feedback(recurrence)
    User.licence.size - recurrence.participations.accepted.size - recurrence.participations.refused.size
  end

end

