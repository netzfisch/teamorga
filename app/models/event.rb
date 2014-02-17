class Event < ActiveRecord::Base
  attr_accessible :category, :base_date, :base_time, :end_date, :place, :remark, :recurrences_attributes
  validates :category, :base_date, :end_date, :place, :presence => true

  has_many :recurrences, :readonly => false, :dependent => :destroy
  accepts_nested_attributes_for :recurrences #, :allow_destroy => true

  default_scope order("base_date DESC, base_time ASC")

  # retrieves the recurrence dates for a named period
  def dates_between(start_date, end_date)
    start_date > end_date ? [start_date] : (start_date..end_date).step(7).to_a
  end
  # Example from IceCube gem to retrieve a list of all dates for a period
  # def self.IceCube_dates_between(start_date, end_date)
  #   # Filtering EventRecurrence on the period using a between named scope
  #   recurrences = EventRecurrence.between(start_date, end_date)
  #
  #   recurrences.inject([]) do |dates, recurrence|
  #     # Use the given dates instead of the ones in the DB
  #     dates.concat(recurrence.dates(:starts => start_date, :until => end_date))
  #   end
  # end

  # creates the event associated recurrences
  def create_recurrences
    dates_between(base_date, end_date).each do |date|
      Recurrence.create(event_id: id, scheduled_to: date)
      # that way no need to set 'attr_accessible :event_id' in recurrence model:
      # r = Recurrence.new
      # r.event_id = id   # unspecific 'r.event = self'
      # r.scheduled_to = date
      # r.save
    end
  end
end
