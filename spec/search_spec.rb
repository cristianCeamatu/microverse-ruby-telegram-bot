require_relative '../lib/search'

describe Search do
  let(:search) { Search.new }

  describe '#check_query' do
    context 'it returns an error when' do
      it 'the query is not between 2-50 chars' do
        expect(search.check_query('a')).to eql("A string of 2-50 characters is required, you typed 'a'")
      end
    end

    context 'it returns the query' do
      it 'the query is between 2-50 chars' do
        expect(search.check_query('ant')).to eql('ant')
      end
    end
  end
end
