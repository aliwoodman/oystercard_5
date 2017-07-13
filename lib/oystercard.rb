require_relative 'journey'
require_relative 'station'

class Oystercard

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :history

  def initialize(balance = 0)
    @balance = balance
    @history = []
  #  @journey = { :entry_station => nil, :exit_station => nil} #to remove
  end

  def top_up(amount)
    fail "Maximum limit exceeded £#{LIMIT}" if amount + balance > LIMIT
    @balance += amount
  end

  def in_journey?
     @journey[:entry_station] != nil
     #journey.status
  end

  def touch_in(station)
    raise "Sorry, not enough balance!" if balance < MINIMUM_FARE
  #  @journey[:entry_station] = station
    @journey = Journey.new
    journey.record_entry_station(station)

  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = station
    @history << journey
    @journey = { :entry_station => nil, :exit_station => nil}
    #journey.record_exit_station(station)
    #journey.save_completed_journey
  end

private

def deduct(fare)
  @balance -= fare
end

end
