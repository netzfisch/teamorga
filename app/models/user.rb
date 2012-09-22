class User < ActiveRecord::Base
  has_many :participations, :dependent => :delete_all
  has_many :recurrences, :through => :participations
  
  has_secure_password
  validates_presence_of :password, :on => :create
  
  #validates :name, :uniqueness => { :case_sensitive => false }, :on => :update
  #validates :shirt_number, :uniqueness, :on => :update
  validates :shirt_number, :length => { :maximum => 2 }
  
  attr_accessible :name, :shirt_number, :birthday, :email, :phone, :password, :password_confirmation, :recurrence_ids
end
