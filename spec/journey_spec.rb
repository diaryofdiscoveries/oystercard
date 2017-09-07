require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:oystercard) {double :oystercard}

    it { is_expected.to respond_to(:entry_station) }
    it { is_expected.to respond_to(:exit_station) }



end
