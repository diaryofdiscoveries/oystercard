require_relative 'station'
require_relative 'oystercard'

class Journey
attr_reader :balance, :entry_station, :exit_station

MINIMUM = 1
PENALTY = 6

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def completed_journey?
    !!entry_station && !!exit_station
  end

  def fare
    if completed_journey?
      MINIMUM
    else
      PENALTY
    end
  end

end
