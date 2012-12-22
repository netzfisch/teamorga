class User < ActiveRecord::Base
  has_many :participations, :include => :recurrence, :dependent => :delete_all
  has_many :recurrences, :through => :participations
  has_many :comments, :dependent => :delete_all

  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false
  has_secure_password

  validates_presence_of :name, :phone, :on => :update
  validates_uniqueness_of :name, :phone, :case_sensitive => false, :on => :update
  validates_length_of :shirt_number, :maximum => 2

  accepts_nested_attributes_for :participations #, :allow_destroy => true
    attr_accessible :admin, :name, :email, :phone, :birthday, :shirt_number, :password, :password_confirmation, :recurrence_ids

  default_scope order("name")

  def participates?(recurrence)
    participations.any? { | participation | participation.recurrence_id == recurrence.id }
  end

end

