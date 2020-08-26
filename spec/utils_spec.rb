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

    it 'returns an error if there is a connection error' do
      expect(results('xx')).to eql('Connection failed, server error or your link is broken please try again!')
    end
  end
end
