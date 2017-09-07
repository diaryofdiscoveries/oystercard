require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end


  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up by amount given' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
      end
    it 'raises an error when over max amount' do
      card_limit = Oystercard::CARD_LIMIT
      oystercard.top_up(card_limit)
      expect { oystercard.top_up 1 }.to raise_error 'Oystercard maximum balance of £90 exceeded'
    end
  end


  describe '# in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}

    it ' is expected to return false at start' do
      expect(oystercard.in_journey?).to eq false
    end
  end


  describe '# touch_in' do
    it 'should make in_journey equal true if funds are greater than minimum' do
      oystercard.top_up(Oystercard::MINIMUM)
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'should record the entry station' do
      oystercard.top_up(Oystercard::MINIMUM)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

    it 'should raise an error if not at minimum balance' do
      expect { oystercard.touch_in(entry_station) }.to raise_error 'Insufficient funds to travel'
    end
  end

  describe '# touch_out' do
    it 'should make in_journey equal false' do
      oystercard.top_up(Oystercard::MINIMUM)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.in_journey?).to eq false
    end


    it 'Should change entry station to nil' do
      oystercard.top_up(Oystercard::MINIMUM)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'stores exit station' do
      oystercard.top_up(Oystercard::MINIMUM)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end

  end

  describe 'journey history' do
    it 'has an empty list of journeys by default' do
      expect(oystercard.history).to eq []
    end

    it "new journey in list contains entry station" do
       oystercard.top_up(Oystercard::MINIMUM)
       oystercard.touch_in(entry_station)
       oystercard.touch_out(exit_station)
       expect(oystercard.history.last.entry_station).to eq entry_station
     end

     it "new journey in list contains exit station" do
       oystercard.top_up(Oystercard::MINIMUM)
       oystercard.touch_in(entry_station)
       oystercard.touch_out(exit_station)
       expect(oystercard.history.last.exit_station).to eq exit_station
     end

  end

  describe "Edge cases" do

    it "touch_out with no touch_in incurs a penalty charge" do
      oystercard.top_up(20)
      penalty = Journey::PENALTY
      expect{oystercard.touch_out(exit_station)}.to change {oystercard.balance}.by(-penalty)
    end

    it "two touch ins incurs penalty fare" do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      penalty = Journey::PENALTY
      expect{oystercard.touch_in(exit_station)}.to change{oystercard.balance}.by -penalty
    end

  end

end
