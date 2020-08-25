#!/usr/bin/env ruby
require 'colorize'
require 'telegram/bot'
require 'dotenv'
Dotenv.load

# Prerequisites
#   ADD Wikipedia URL to the Environments
#     Search Class
#       - check_query(query)
#     Random Class
#     Utils module
#       - uri(url, query = nil)
#       - loading_message(query = nil)
#       - result.to_markdown
#       - counter(seconds)
#       - get_results(uri)

# p 'The ruby bot has started, you can check it at the link: https://t.me/rock_paper_scissors2020_bot'

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API'], logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started, you can check it at the link:' << ' https://t.me/rock_paper_scissors2020_bot'.yellow.bold)
  # Print a nice an funny message (maybe with a Gif) that we can find anything: Have questions? I have the answeres!
  #I am the Search Bot! Don`t know what to search? Type /random to get a random Wikipedia link
  bot.listen do |message|
    # Accepts both inline messages and direct chat, has the same response in both cases
    #   start a case for the message text:
    #   when the message starts with `search`
    #     if is followed by a `query string` (length: maximum 50, minimum 2)
    #       Print a message that we are searching the Wikipedia website for results
    #       Set the url for Wikipedia with the escaped string attached
    #       Request 5-10 results from Wikipedia as JSON
    #       Convert them to the appropriate format (Check HTML or Markdown)
    #       Send the result
    #     else return an message asking to enter a string having between 2-50 characters
    #   when the stripped message is `random`
    #     Print a message that we are returning an Wikipedia random search
    #     Set the url for Wikipedia with the escaped string attached
    #     Request 5-10 results from Wikipedia as JSON
    #     Convert them to the appropriate format (Check HTML or Markdown)
    #     Send the result
    #   else
    #     return a funny error message (maybe a GIF)
    # asking to use only the available commands and run 
    # help to see all available
    #     print the command that the User entered
    # future improvements, search synonims API for searching synonims and search google API for searching anything
    # add a game of Tic Tac Toe or Rock Paper Scissors

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

# p message.text
# case message.text
# when '/start'
#   bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
# when '/stop'
#   bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
# # when '/dice'
# #   bot.api.sendDice(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
# else
#   bot.api.send_message(chat_id: message.chat.id, text: "Why you wrote `#{message.text}`")
# end
