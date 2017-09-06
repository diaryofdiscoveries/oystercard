class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :history
  CARD_LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail 'Insufficient funds to travel' if balance < MINIMUM
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM)
    @exit_station = exit_station
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    @history << current_journey
    @entry_station = nil
  end

private

def deduct(amount)
  @balance -= amount
end

end

=begin
def touch in(station)
@entry_station = station
=end
