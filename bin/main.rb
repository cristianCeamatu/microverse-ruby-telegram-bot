#!/usr/bin/env ruby

require 'colorize'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API'], logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started, you can check it at the link:' << ' https://t.me/rock_paper_scissors2020_bot'.yellow.bold)

  bot.listen do |message|
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
