#!/usr/bin/env ruby # rubocop:disable Lint/ScriptPermission, Lint/RedundantCopDisableDirective

require 'colorize'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

require_relative '../lib/utils'
require_relative '../lib/search'
# Prerequisites
#   ADD Wikipedia URL to the Environments
#     Search Class
#       - check_query(query)
#       - loading_message(query)
#     Random Class
#       - loading_message
#     Utils module
#       - uri(query = nil)
# #     - loading_message(query = nil)
#       - result.to_markdown
#       - counter(seconds)
#       - results(uri)

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN'], logger: Logger.new($stderr)) do |bot| # rubocop: disable Metrics/BlockLength
  include Utils

  bot.logger.info('Bot has been started, you can check it at the link:' << ' http://t.me/master_search_ruby_bot'.yellow.bold)
  gif_items = results(ENV['TENOR_BASE_URI'])['results'].map { |el| el['media'][0]['gif']['url'] }
  bot.listen do |message| # rubocop: disable Metrics/BlockLength
    # Accepts both inline messages and direct chat, has the same response in both cases
    # help to see all available
    # future improvements, search synonims API for searching synonims and search google API for searching anything

    gif = gif_items[rand(1..10)] if gif_items
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: 'Did somebody call the Master Search bot?')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: "Was that you #{message.from.first_name}?")
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Have questions? I have the answers!')
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Type `/search wiki <and your query>` to see what I can do!')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Type `/search wiki random` to get 3 random results')
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: 'You can never stop me!')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '<b>I know who you are and where you live!!!</b>', parse_mode: 'HTML') # rubocop: disable Layout/LineLength
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: message.from.first_name)
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: 'Available commands:')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '/search wiki <your search query>')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '/search wiki random (get 3 random results)')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Don`t be shy, just try!')
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    when /^\/search wiki /i # rubocop: disable Style/RegexpLiteral
      query = get_query_from_message(message.text)
      search = Search.new(query)

      if query.downcase == 'random'
        bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 random wikipedia results:')
        response = search.results(uri(nil))
        response['query']['pages'].to_a.each do |el|
          sleep 1
          bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el[1]['title']}")
        end
      elsif search.check_query(query) == query.strip
        bot.api.send_message(chat_id: message.chat.id, text: "You are searching on Wikipedia for `#{get_query_from_message(message.text)}`!") # rubocop: disable Layout/LineLength
        sleep 1
        bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 wikipedia results:')
        sleep 1
        response = search.results(uri(query.strip))
        response['query']['search'].each do |el|
          bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el['title']}")
          sleep 1
        end
      else
        bot.api.send_message(chat_id: message.chat.id, text: search.check_query(query)) unless search.check_query(query) == query.strip # rubocop: disable Layout/LineLength
        bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Why you wrote `#{message.text}`")
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'You need to write one of the following commands:')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/start` to get a nice Gif and a greetings message')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/search wiki <your search query>`')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/search wiki random` (get 3 random results)')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/stop` to get a bad Gif and a Bye Bye message')
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    end
  end
end
