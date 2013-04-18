class Event < ActiveRecord::Base
  has_many :recurrences, :dependent => :destroy

  attr_accessible :category, :base_date, :base_time, :end_date, :place, :remark

  validates :category, :base_date, :place, :presence => true

  default_scope order("base_date DESC, base_time ASC")

  # Retrieves a list of all recurrence dates for the named period
  def dates_between(start_date, end_date)
     start_date > end_date ? [start_date] : (start_date..end_date).step(7).to_a
  end

  # Example from IceCube gem to retrieve a list of all dates for a period
  #def self.IceCube_dates_between(start_date, end_date)
  #  # Filtering EventRecurrence on the period using a between named scope
  #  recurrences = EventRecurrence.between(start_date, end_date)
  #
  #  recurrences.inject([]) do |dates, recurrence|
  #    # Use the given dates instead of the ones in the DB
  #    dates.concat(recurrence.dates(:starts => start_date, :until => end_date))
  #  end
  #end

end

