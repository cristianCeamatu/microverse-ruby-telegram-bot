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

  def to_markdown(results)
    result = ''
    results.each do |item|
      result += "#{item[0]}: #{item[1]}"
    end
    result
  end

  def results(uri)
    response = ''
    begin
      response = JSON.parse(HTTParty.get(uri).body)
    rescue => e # rubocop:disable Style/RescueStandardError, Lint/UselessAssignment
      response = 'No results found, please try again!'
    end
    response
  end
end
