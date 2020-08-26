# !/usr/bin/env ruby

require 'colorize'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

require_relative '../lib/utils'
require_relative '../lib/search'

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN'], logger: Logger.new($stderr)) do |bot| # rubocop: disable Metrics/BlockLength
  include Utils

  bot.logger.info('Bot has been started, you can check it at the link: ' << 'http://t.me/master_search_ruby_bot'.yellow.bold)

  bot.listen do |message| # rubocop: disable Metrics/BlockLength
    # Accepts both inline messages and direct chat, has the same response in both cases

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
      bot.api.send_message(chat_id: message.chat.id, text: 'Type `search wiki <and some text>` to see what I can do!')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Type `search wiki random` to get 3 random results')
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
      bot.api.send_message(chat_id: message.chat.id, text: 'search wiki <and some text>')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'search wiki random (get 3 random results)')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'Don`t be shy, just try!')
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    when /^search wiki /i
      query = get_query_from_message(message.text)
      search = Search.new

      if query.downcase == 'random'
        bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 random wikipedia results:')
        search.results('wiki-random', uri('wiki', nil)).each do |el|
          sleep 1
          bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el[:title]}")
        end
      elsif search.check_query(query) == query.strip
        bot.api.send_message(chat_id: message.chat.id, text: "You are searching on Wikipedia for `#{query}`!")
        sleep 1
        bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 wikipedia results:')
        sleep 1
        search.results('wiki-search', uri('wiki', query.strip)).each do |el|
          bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el[:title]}")
          sleep 1
        end
      else
        bot.api.send_message(chat_id: message.chat.id, text: search.check_query(query))
        bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
      end
    when /^search google /i
      query = get_query_from_message(message.text)
      search = Search.new

      if search.check_query(query) == query.strip
        bot.api.send_message(chat_id: message.chat.id, text: "You are searching on Google for `#{query}`!")
        sleep 1
        bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 Google results:')
        sleep 1
        response = search.results('google', uri('google', query.strip))

        if response.is_a?(String)
          bot.api.send_message(chat_id: message.chat.id, text: response)
        else
          search.results('google', uri('google', query.strip)).each do |el|
            bot.api.send_message(chat_id: message.chat.id, text: el[:link])
            sleep 1
          end
        end
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Why you wrote `#{message.text}`")
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'You need to write one of the following commands:')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/start` to get a nice Gif and a greetings message')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`search wiki <and some text>`')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`search wiki random` (get 3 random results)')
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: '`/stop` to get a bad Gif and a Bye Bye message')
      sleep 1
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    end
  end
end
