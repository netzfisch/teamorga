class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations
  has_many :comments, :dependent => :delete_all #, :order => 'created_at DESC'

  validates_presence_of :scheduled_to

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids

  default_scope order("scheduled_to ASC")
  scope :current, lambda { (where("scheduled_to >= ?", Time.zone.today))}

  # TODO combinig current & paginate with scope
  def self.current_paginate(page, per_page)
    recurrences = current.paginate(page, per_page)
  end

  def users_accepted(recurrence)
    recurrence.users.find(:all, conditions: ["recurrence_id = ? AND status = ? ", recurrence.id, true])
  end

  def users_refused(recurrence)
    recurrence.users.find(:all, conditions: ["recurrence_id = ? AND status = ? ", recurrence.id, false])
  end

  def users_open(recurrence)
    User.count - (users_accepted(recurrence).count + users_refused(recurrence).count)
  end
end

