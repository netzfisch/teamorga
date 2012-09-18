class Recurrence < ActiveRecord::Base
  belongs_to :event
  has_many :participations, :include => :user, :dependent => :delete_all
  has_many :users, :through => :participations
  
  #accepts_nested_attributes_for :participations, :allow_destroy => true
  
  attr_accessible :scheduled_to, :event_id, :user_ids
end
