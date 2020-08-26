require_relative '../lib/utils'
require 'dotenv'
Dotenv.load

describe Utils do
  include Utils

  describe '#uri' do
    let(:random_uri) { "#{ENV['WIKIPEDIA_BASE_URI']}&generator=random&grnnamespace=0&grnlimit=3" }

    it 'return the Wikipedia Random URI when there is no parameter received' do
      expect(uri).to eql(random_uri)
    end
    context 'the first parameter is wiki and the second' do
      let(:wiki_search_url) { "#{ENV['WIKIPEDIA_BASE_URI']}&list=search&utf8=1&origin=*&srlimit=3&srsearch=" }

      it 'is nil, it returns the Random URI Wikipedia API link' do
        expect(uri('wiki')).to eql(random_uri)
      end

      it 'is a string, it returns the Search URI Wikipedia with the parameter as a query' do
        expect(uri('wiki', 'text')).to eql("#{wiki_search_url}text")
      end
    end

    context 'the first parameter is google and the second' do
      let(:google_search_url) { ENV['GOOGLE_BASE_URI'] }

      it 'is nil, it returns the Google API URI with the query `google`' do
        expect(uri('google')).to eql("#{google_search_url}google")
      end

      it 'is a string, it returns the GOOGLE URI with the parameter as a query' do
        expect(uri('google', 'text')).to eql("#{google_search_url}text")
      end
    end
  end

  describe '#results(uri)' do
    it 'returns an Array' do
      expect(results('google', uri('google', 'text'))).to be_a(Array)
    end

    it 'returns an error if there are no results' do
      expect(results('xx', 'xx')).to eql('0 results found for your search, please try again!')
    end
  end
end
