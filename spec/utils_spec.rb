require_relative '../lib/utils'
require 'dotenv'
Dotenv.load

describe Utils do
  include Utils

  describe '#uri' do
    context 'when the parameter' do
      let(:search_url) { "#{ENV['WIKIPEDIA_BASE_URI']}&list=search&utf8=1&origin=*&srlimit=3&srsearch=" }
      let(:random_uri) { "#{ENV['WIKIPEDIA_BASE_URI']}&generator=random&grnnamespace=0&grnlimit=3" }

      it 'is nil, it returns the Random URI Wikipedia API link' do
        expect(uri).to eql(random_uri)
      end

      it 'is a string, it returns the Search URI Wikipedia with the parameter as a query' do
        expect(uri('text')).to eql("#{search_url}text")
      end
    end
  end

  describe '#results(uri)' do
    it 'returns a JSON that we convert to a hash with JSON.parse' do
      expect(results(uri)).to be_a(Hash)
    end

    it 'returns an error if we don`t have results' do
      expect(results('xx')).to eql('No results found, please try again!')
    end
  end

  describe '#to_markdown' do
    # before, we need to get a resultJSON
    result = JSON.parse('{"one":1,"two":2}')
    it 'converts JSON/Hash result to string(markdown/html)' do
      expect(to_markdown(result)).to be_a(String)
    end
  end

  describe '#results(uri)' do
    it 'returns a JSON that we convert to a hash with JSON.parse' do
      expect(results(uri)).to be_a(Hash)
    end

    it 'returns an error if we don`t have results' do
      expect(results('xx')).to eql('No results found, please try again!')
    end
  end
end
