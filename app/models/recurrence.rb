class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :dependent => :delete_all, :include => :user
  has_many :users, :through => :participations #, :include => :user
  has_many :comments, :dependent => :delete_all
  
  accepts_nested_attributes_for :participations #, :allow_destroy => true
  
  #named_scope :recent, :order => :scheduled_to, :limit => 10 
  
  attr_accessible :scheduled_to, :event_id, :user_id, :user_ids
   
  def self.custom_paginate(collection, options = {})
    defaults = { 
      :conditions => { :scheduled_to => (Date.today)..(Date.today + 1.year) }
    }
    options = defaults.merge(options)
    paginate collection, options
  end  
 
end
