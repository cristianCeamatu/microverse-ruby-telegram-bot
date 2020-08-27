require_relative './utils'

class Search
  include Utils

  def check_query(query)
    return "A string of 2-50 characters is required, you typed '#{query}'" unless query.strip.size.between?(2, 50)
    return "Only alphanumerical chars accepted, you typed '#{query}'" unless query.strip.match(/^[0-9A-Z ]+$/i)

    query.strip
  end
end
