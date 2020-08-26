require 'httparty'

module Utils
  def uri(query = nil)
    return "#{ENV['WIKIPEDIA_BASE_URI']}&generator=random&grnnamespace=0&grnlimit=3" if query.nil?

    "#{ENV['WIKIPEDIA_BASE_URI']}&list=search&utf8=1&origin=*&srlimit=3&srsearch=#{query}"
  end

  def get_query_from_message(message)
    array = message.split
    array[2, array.size - 1].join(' ')
  end

  def results(uri)
    response = ''
    begin
      response = JSON.parse(HTTParty.get(uri).body)
      response = response.size.positive? ? response : '0 results found for your search, please try again!'
    rescue => e # rubocop:disable Style/RescueStandardError, Lint/UselessAssignment
      response = 'Connection failed, server error or your link is broken please try again!'
    end
    response
  end

  def gif_items
    results(ENV['TENOR_BASE_URI'])['results'].map { |el| el['media'][0]['gif']['url'] }
  end
end
