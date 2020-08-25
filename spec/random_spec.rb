require_relative '../lib/random'
require_relative '../lib/utils'

describe Random do
  let(:random) { Random.new }

  it 'includes the Utils module' do
    expect(random.singleton_class.include?(Utils)).to eql(true)
  end

  it 'has a loading message' do
    expect(random.loading_message).to be_a(String)
  end
end
