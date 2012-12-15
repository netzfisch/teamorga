class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations
  has_many :comments, :dependent => :delete_all #, :order => 'created_at DESC'

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids

  default_scope order("scheduled_to")
  scope :current, lambda { where("scheduled_to >= ?", Time.zone.now) }

  # TODO combinig current & paginate with scope
  def self.current_paginate(page, per_page)
    recurrences = current.paginate(page, per_page)
  end
end

