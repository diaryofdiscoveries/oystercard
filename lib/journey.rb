require_relative 'station'
require_relative 'oystercard'

class Journey
attr_reader :balance, :entry_station, :exit_station, :history

MINIMUM = 1

  def initialize
    @history = []
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    self.touch_out(nil) if in_journey? == true
    fail 'Insufficient funds to travel' if balance < MINIMUM
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM)
    @exit_station = exit_station
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    current_journey.fare
    @history << current_journey
    @entry_station = nil
  end

  def fare(current_journey)
    if :entry_station == nil
      return deduct(PENALTY)
    elsif :exit_station == nil
      return deduct(PENALTY)
    else
      deduct(MINIMUM)
    end
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

end
