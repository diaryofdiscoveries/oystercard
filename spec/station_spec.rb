require 'station'

describe Station do
  subject(:station) { described_class.new("Victoria", 1) }

  it 'knows its name' do
    expect(station.name).to eq "Victoria"
  end

  it 'knows its zone' do
    expect(station.zone).to eq 1
  end
end
