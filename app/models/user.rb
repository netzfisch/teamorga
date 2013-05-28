class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :participations, :include => :recurrence, :dependent => :destroy
  has_many :recurrences, :through => :participations
  has_many :comments, :dependent => :destroy

  validates_presence_of :email, :password, :on => :create
  #validates_uniqueness_of :email, :case_sensitive => false
  has_secure_password

  validates_presence_of :name, :phone, :on => :update
  validates_uniqueness_of :name, :phone, :case_sensitive => false, :on => :update
  validates_length_of :shirt_number, :maximum => 2

  accepts_nested_attributes_for :participations #, :allow_destroy => true
    attr_accessible :admin, :name, :email, :phone, :birthday, :shirt_number, :password, :password_confirmation, :recurrence_ids

  default_scope order("name")
  scope :licence, where("shirt_number IS NOT NULL") # count(:shirt_number) or shirt_number.exist?
  #scope :upcoming_birthdays, lambda { where("User.next_birthday between ? and ?", Date.today - 1.week, Date.today + 2.weeks) }

  def responded?(recurrence)
    participations.any? { | participation | participation.recurrence_id == recurrence.id }
  end

  def responded_at(recurrence)
    participations.where("recurrence_id = ?", recurrence.id).first
  end

  #def responded_at_with(recurrence, status)
  #  participations.where("recurrence_id = ? AND status = ? ", recurrence.id, status).all
  #end

  def next_birthday
    birthday = Date.new(Date.today.year, self.birthday.month, self.birthday.day)
    birthday += 1.year if birthday < Date.today 
  end

  def upcoming_birthdays
    # birthdays = User.find(:all).
    where("next_birthday between ? and ?", Date.today - 1.week, Date.today + 2.weeks) }
    # birthdays = User.find(:all, :select => 'id, birthday').sort_by(&:next_birthday).first(5)
  end
end

