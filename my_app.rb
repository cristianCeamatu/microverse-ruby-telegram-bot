# myapp.rb
require 'sinatra'

get '/' do
  sleep 3
  redirect 'http://t.me/master_search_ruby_bot', 303
end
