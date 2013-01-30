class User < ActiveRecord::Base
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

