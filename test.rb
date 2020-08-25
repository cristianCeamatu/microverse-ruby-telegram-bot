require 'httparty'
require 'dotenv'
require_relative './lib/utils'

Dotenv.load

# response = JSON.parse(HTTParty.get("#{ENV['WIKIPEDIA_BASE_URI']}&list=search&utf8=1&origin=*&srlimit=5&srsearch=cris").body)
# response['query']['search'].each do |el|
#   p el['snippet']
# end
# response['query']['pages'].to_a.each do |el|
#   p el[1]['title']
# end
include Utils

gif_items = results(ENV['TENOR_BASE_URI'])['results'].map { |el| el['media'][0]['gif']['url'] }
gif = gif_items[rand(1..10)] if gif_items
p gif