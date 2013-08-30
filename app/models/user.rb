class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :email, :password, :password_confirmation, :birthday, 
                  :admin, :phone, :shirt_number, 
                  :recurrence_ids

  validates_presence_of :name, :email, :password, :on => :create
  #validates_uniqueness_of :email, :case_sensitive => false
  has_secure_password

  validates_presence_of :birthday, :phone, :on => :update
  validates_uniqueness_of :name, :phone, :case_sensitive => false, :on => :update
  validates_length_of :shirt_number, :maximum => 2

  has_many :participations, :include => :recurrence, :dependent => :destroy
  has_many :recurrences, :through => :participations
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :participations #, :allow_destroy => true

  default_scope order("name")
  scope :licence, where("shirt_number IS NOT NULL") # count(:shirt_number) or shirt_number.exist?

  def self.upcoming_birthdays
    anniversarys = []

    find(:all).each do |user|
      if user.next_birthday.between?(Date.current, Date.current + 3.weeks)
        anniversarys << user
      end
    end

    return anniversarys.sort_by { |u| u.next_birthday }
  end

  def next_birthday
    anniversary = Date.new(Date.current.year, self.birthday.month, self.birthday.day)
    anniversary.past? ? anniversary + 1.year : anniversary
  end

  def next_birthday_age
    self.next_birthday.year - self.birthday.year
  end

  def current_age
    anniversary = Date.new(Date.current.year, self.birthday.month, self.birthday.day)
    age = Date.current.year - self.birthday.year
    anniversary.future? ? age - 1 : age
  end

  def responded?(recurrence)
    participations.any? { | participation | participation.recurrence_id == recurrence.id }
  end

  def responded_at(recurrence)
    participations.where("recurrence_id = ?", recurrence.id).first
  end

  #def responded_at_with(recurrence, status)
  #  participations.where("recurrence_id = ? AND status = ? ", recurrence.id, status).all
  #end
end
