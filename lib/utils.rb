require 'httparty'
require 'dotenv'
Dotenv.load

module Utils
  def uri(type = 'wiki', query = nil)
    case type
    when 'wiki'
      return "#{ENV['WIKIPEDIA_BASE_URI']}&generator=random&grnnamespace=0&grnlimit=3" if query.nil?

      "#{ENV['WIKIPEDIA_BASE_URI']}&list=search&utf8=1&origin=*&srlimit=3&srsearch=#{query}"
    when 'google'
      return "#{ENV['GOOGLE_BASE_URI']}google" if query.nil?

      "#{ENV['GOOGLE_BASE_URI']}#{query}"
    else
      "#{ENV['WIKIPEDIA_BASE_URI']}&generator=random&grnnamespace=0&grnlimit=3"
    end
  end

  def get_query_from_message(message)
    array = message.split
    array[2, array.size - 1].join(' ')
  end

  # rubocop: disable Metrics/CyclomaticComplexity
  def results(type, uri)
    begin
      response = JSON.parse(HTTParty.get(uri).body)
      response = case type
                 when 'wiki-search'
                   response['query']['search'].map { |el| { title: el['title'] } }
                 when 'wiki-random'
                   response['query']['pages'].map { |el| { title: el[1]['title'] } }
                 when 'google'
                   response['items'][0..2].map { |el| { title: el['title'], link: el['link'] } }
                 when 'gif'
                   response['results'].map { |el| el['media'][0]['gif']['url'] }
                 else
                   response['items'][0..2].map { |el| { title: el['title'], link: el['link'] } }
                 end
      response = response.size.positive? ? response : '0 results found for your search, please try again!'
    rescue => e # rubocop:disable Style/RescueStandardError, Lint/UselessAssignment
      response = '0 results found for your search, please try again!'
    end
    response
  end
  # rubocop: enable Metrics/CyclomaticComplexity

  def gif_items
    results('gif', ENV['TENOR_BASE_URI'])
  end
end
