class User < ActiveRecord::Base
  has_many :participations, :include => :recurrence, :dependent => :delete_all
  has_many :recurrences, :through => :participations
  has_many :comments, :dependent => :delete_all

  accepts_nested_attributes_for :participations #, :allow_destroy => true

  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false
  has_secure_password

  validates_presence_of :name, :phone, :on => :update
  validates_uniqueness_of :name, :phone, :on => :update
  validates :shirt_number, :length => { :maximum => 2 }

  attr_accessible :name, :email, :phone, :birthday, :shirt_number, :password, :password_confirmation, :recurrence_ids
end

