require 'httparty'
require 'dotenv'
Dotenv.load

module Utils
  def uri(query = nil)
    return ENV['WIKIPEDIA_RANDOM_API'] if query.nil?

    result = "#{ENV['WIKIPEDIA_SEARCH_API']}#{query}"
    result
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
