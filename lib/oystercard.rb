class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90
  MINIMUM = 1
  PENALTY = 6

  def initialize
    @balance = 0
  #  history = [ ]
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

=begin  def in_journey?
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
    return deduct(MINIMUM)
  else
    deduct(MINIMUM)
  end
=end
private

def deduct(amount)
  @balance -= amount
end

end

=begin
def touch in(station)
@entry_station = station
=end
