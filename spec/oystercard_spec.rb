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
    it 'raises an error when over max amount' do
      card_limit = Oystercard::CARD_LIMIT
      oystercard.top_up(card_limit)
       expect { oystercard.top_up 1 }.to raise_error 'Oystercard maximum balance of £90 exceeded'
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts balance by amount given' do
      expect{ oystercard.deduct 1 }.to change{ oystercard.balance }.by -1
      end
  end

  describe '# in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}

    it ' is expected to return false at start' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '# touch_in' do
    it 'should make in_journey equal true' do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end
  end

  describe '# touch_out' do
    it 'should make in_journey equal false' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
  end
end
