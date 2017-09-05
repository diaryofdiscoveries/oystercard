class Oystercard
  attr_reader :balance, :in_journey, :entry_station
  CARD_LIMIT = 90
  MINIMUM = 1

  def initialize(in_journey = false, entry_station = nil)
    @balance = 0
    @in_journey = in_journey
    @entry_station = entry_station
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in(station)
    fail 'Insufficient funds to travel' if balance < MINIMUM
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM)
    @in_journey = false
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
