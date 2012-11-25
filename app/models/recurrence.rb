class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations #, :include => :user
  has_many :comments, :dependent => :delete_all #, :order => 'created_at DESC'

  accepts_nested_attributes_for :participations #, :allow_destroy => true
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids

  scope :current, lambda { where("scheduled_to >= ?", Time.zone.now ) }
  scope :visible, current.order("scheduled_to")

  # TODO combinig visible with scope
  def self.visible_paginate(page, per_page)
    recurrences = visible.paginate(page, per_page)
  end
end

