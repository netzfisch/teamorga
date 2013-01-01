class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations
  has_many :comments

  validates_presence_of :scheduled_to

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids

  default_scope order("scheduled_to ASC")
  scope :current, lambda { where("scheduled_to >= ?", Time.zone.today) }
  scope :r_refused, lambda {
    joins(:participations).group("users.id") & Participation.refused }

  # TODO combinig current & paginate with scope
  def self.current_paginate(page, per_page)
    recurrences = current.paginate(page, per_page)
  end


  def users_accepted(recurrence)
    recurrence.users.find(:all, conditions: ["recurrence_id = ? AND status = ? ", recurrence.id, true])
  end

r.users.find(:all, conditions: ["recurrence_id = ? AND status = ? ", r.id, false])
  User Load (0.8ms)
  SELECT "users".* FROM "users"
    INNER JOIN "participations" ON "users"."id" = "participations"."user_id"
    WHERE "participations"."recurrence_id" = 19 AND (recurrence_id = 19 AND status = 'f' )
    ORDER BY name
=> []

scope :refused, where(status: false)
r.participations.refused
  Participation Load (0.4ms)
    SELECT "participations".* FROM "participations"
    WHERE "participations"."recurrence_id" = 19 AND "participations"."status" = 'f'
=> []


  def users_refused(recurrence)
    recurrence.users.find(:all, conditions: ["recurrence_id = ? AND status = ? ", recurrence.id, false])
  end


  def users_open(recurrence)
    User.count(:shirt_number) - recurrence.participations.accepted.size - recurrence.participations.refused.size
  end

end

