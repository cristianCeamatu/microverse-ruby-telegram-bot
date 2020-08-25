require 'json'

require_relative '../lib/utils'

describe Utils do
  describe '#loading_message' do
    @message = 'Wait while I use my super powers to give you a random article.' \
      'I could return the result instantly but counters make me feel important :D'
    it 'returns a message describing a Random query request' do
      expect(Random.loading_message).to eql(message)
    end
  end

  describe '#uri' do
    context 'when the second parameter' do
      @url = ENV['WIKIPEDIA_URL_API']

      it 'is nil, it returns the Random URI Wikipedia link' do
        expect(Random.uri(url)).to eql(ENV['WIKIPEDIA_URL_API'] << 'random')
      end

      it 'is a string, it returns the Search URI Wikipedia with the parameter as a query' do
        expect(Random.uri(url)).to eql(ENV['WIKIPEDIA_URL_API'] << 'query')
      end
    end
  end

  describe '#to_markdown' do
    # before, we need to get a resultJSON
    result_json = '{"one":1,"two":2}'.to_json
    it 'converts json to string(markdown/html)' do
      expect(to_markdown(result_json)).to be_a(String)
    end
  end

  describe '#get_results' do
    it 'returns a JSON that we convert to a hash with JSON.parse' do
      expect(JSON.parse(get_results(uri))).to be_a(Hash)
    end

    it 'returns an error if we don`t have results' do
      expect(get_results(uri)).to eql('No results found, please try again!')
    end
  end
end
