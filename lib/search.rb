require_relative './utils'

class Search
  include Utils
  attr_reader :loading_message

  def initialize(query)
    @loading_message = 'Wait while I use my super powers to give you the results.' \
    "You searched for: #{query}" \
    'I could return the result instantly but counters make me feel important :D'
  end

  def check_query(query)
    return "A string of 2-50 characters is required, you typed '#{query}'" unless query.strip.size.between?(2, 50)
    return "Only alphanumerical chars accepted, you typed '#{query}'" unless query.strip.match(/^[0-9A-Z ]+$/i)

    query.strip
  end
end
