class User < ActiveRecord::Base
  has_many :participations, :dependent => :delete_all
  has_many :recurrences, :through => :participations
  
  has_secure_password
  validates_presence_of :password, :on => :create
  
#  validates :name, :email, :uniqueness => { :case_sensitive => false }
#  validates :shirt_number, :uniqueness #, :on => :edit
  validates :shirt_number, :length => { :maximum => 2 }
  
  attr_accessible :name, :shirt_number, :email, :phone, :password, :password_confirmation, :recurrence_ids
end
