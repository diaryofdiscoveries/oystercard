require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:oystercard) {double :oystercard}

    it { is_expected.to respond_to(:entry_station) }
    it { is_expected.to respond_to(:exit_station) }
    it { is_expected.to respond_to(:touch_in) }
    it { is_expected.to respond_to(:touch_out) }
    it { is_expected.to respond_to(:fare) }


    it 'makes exit_station equal to nil if fails to touch out' do
      oystercard.top_up(Oystercard::MINIMUM)
      journey.touch_in(entry_station)
      journey.touch_in(entry_station)
      expect(journey.exit_station).to eq nil #need to change this
    end

    it 'charges a penalty when entry_station is nil' do
      journey.entry_station = nil
      expect(journey.fare).to eq 6
    end

    it 'charges a penalty when exit_station is nil' do
      journey.exit_station = nil
      expect(journey.fare).to eq 6
    end

    describe '# in_journey?' do
      it { is_expected.to respond_to(:in_journey?)}

      it ' is expected to return false at start' do
        expect(journey.in_journey?).to eq false
      end
    end

    describe '# touch_in' do
      it 'should make in_journey equal true if funds are greater than minimum' do
        oystercard.top_up(Oystercard::MINIMUM)
        journey.touch_in(entry_station)
        expect(journey.in_journey?).to eq true
      end

      it 'should record the entry station' do
        oystercard.top_up(Oystercard::MINIMUM)
        journey.touch_in(entry_station)
        expect(journey.entry_station).to eq entry_station
      end

      it 'should raise an error if not at minimum balance' do
        expect { journey.touch_in(entry_station) }.to raise_error 'Insufficient funds to travel'
      end
    end

    describe '# touch_out' do
      it 'should make in_journey equal false' do
        oystercard.top_up(Oystercard::MINIMUM)
        journey.touch_in(entry_station)
        journey.touch_out(exit_station)
        expect(journey.in_journey?).to eq false
      end

      it 'should deduct the minimum fare' do
          oystercard.top_up(Oystercard::MINIMUM)
          expect{ journey.touch_out(exit_station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM)
      end

      it 'Should change entry station to nil' do
        oystercard.top_up(Oystercard::MINIMUM)
        journey.touch_in(entry_station)
        journey.touch_out(exit_station)
        expect(journey.entry_station).to eq nil
      end

      it 'stores exit station' do
        oystercard.top_up(Oystercard::MINIMUM)
        journey.touch_in(entry_station)
        journey.touch_out(exit_station)
        expect(journey.exit_station).to eq exit_station
      end

    end

    describe 'journey history' do
      it 'has an empty list of journeys by default' do
        expect(journey.history).to eq []
      end
    end

    it 'checks that touching in and out creates one journey' do
      oystercard.top_up(Oystercard::MINIMUM)
      journey.touch_in(entry_station)
      journey.touch_out(exit_station)
      expect(journey.history).to eq [{ entry_station: entry_station, exit_station: exit_station }]

    end


end
