class Event < ActiveRecord::Base
  has_many :recurrences, :dependent => :delete_all

  attr_accessible :category, :base_date, :base_time, :end_date, :place, :remark

  validates :category, :base_date, :place, :presence => true

  # Retrieves a list of all recurrence dates for the named period
  def self.dates_between(start_date, end_date)
     recurrences = (start_date..end_date).step(7).to_a
  end

  # Example from IceCube gem to retrieves a list of all dates for a period
  def self.dates_betweenIceCube(start_date, end_date)
    # Filtering EventRecurrence on the period using a between named scope
    recurrences = EventRecurrence.between(start_date, end_date)

    recurrences.inject([]) do |dates, recurrence|
      # Use the given dates instead of the ones in the DB
      dates.concat(recurrence.dates(:starts => start_date, :until => end_date))
    end
  end

end

