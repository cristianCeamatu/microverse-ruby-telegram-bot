#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv'

Dotenv.load

p 'The ruby bot has started'

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API']) do |bot|
  bot.listen do |message|
    p message.text
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    # when '/dice'
    #   bot.api.sendDice(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Why you wrote `#{message.text}`")
    end
  end
end
