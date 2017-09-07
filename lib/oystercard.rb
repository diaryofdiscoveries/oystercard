require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :history, :current_journey
  CARD_LIMIT = 90
  MINIMUM = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @history = []
    @current_journey = current_journey
  end

  def top_up(amount)
    raise 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    touch_out(nil) if in_journey? == true
    raise 'Insufficient funds to travel' if balance < MINIMUM
    @entry_station = entry_station
    @current_journey = Journey.new(entry_station: entry_station)
  end

  def touch_out(exit_station)
    touch_in(nil) if in_journey? == false
    @exit_station = exit_station
    @current_journey.finish(exit_station)
    process_current_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def process_current_journey
    deduct(@current_journey.fare)
    history << @current_journey
    @current_journey = nil
    @entry_station = nil
  end
end
