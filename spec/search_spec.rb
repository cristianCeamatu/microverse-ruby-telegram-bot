require_relative '../lib/search'
require_relative '../lib/utils'

describe Search do
  let(:query) { 'text' }
  let(:search) { Search.new }

  it 'includes the Utils module' do
    expect(search.singleton_class.include?(Utils)).to eql(true)
  end

  describe '#check_query' do
    context 'it returns an error when' do
      it 'the query is not between 2-50 chars' do
        expect(search.check_query('a')).to eql("A string of 2-50 characters is required, you typed 'a'")
      end

      it 'the query is not only alphanumerical chars' do
        expect(search.check_query('a_@')).to eql("Only alphanumerical chars accepted, you typed 'a_@'")
      end
    end

    context 'returns the query when passes the filters, accepts:' do
      it 'between 2-50 length strings and alphanumerical chars' do
        expect(search.check_query('ant')).to eql('ant')
      end

      it 'spaces between words' do
        expect(search.check_query('ant plant')).to eql('ant plant')
      end

      it 'trims the string (removes left and right empty spaces)' do
        expect(search.check_query(' ant ')).to eql('ant')
      end
    end
  end
end
