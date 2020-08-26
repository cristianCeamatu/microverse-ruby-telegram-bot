# !/usr/bin/env ruby

require 'colorize'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

require_relative '../lib/responder'

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN'], logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started at: ' << 'http://t.me/master_search_ruby_bot'.yellow.bold)

  bot.listen do |message|
    options = { bot: bot, message: message }
    Responder.new(options).respond
  end
end
