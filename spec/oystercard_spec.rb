require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up by amount given' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
  end

end
