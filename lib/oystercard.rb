class Oystercard
  attr_reader :balance, :entry_station
  CARD_LIMIT = 90
  MINIMUM = 1

  def initialize(entry_station = nil)
    @balance = 0
    @entry_station = entry_station
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail 'Insufficient funds to travel' if balance < MINIMUM
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM)
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
