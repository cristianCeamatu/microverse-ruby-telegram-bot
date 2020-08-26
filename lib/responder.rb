require_relative './bot_replies'
require_relative './utils'

class Responder
  include Utils
  include BotReplies

  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def respond
    gif = gif_items[rand(1..10)] if gif_items

    case message.text
    when '/start'
      start_response(bot, message, gif)
    when '/stop'
      stop_response(bot, message, gif)
    when '/help'
      help_response(bot, message, gif)
    when /^search wiki /i
      search_wiki_response(bot, message, gif)
    when /^search google /i
      search_google_response(bot, message, gif)
    else
      random_text_response(bot, message, gif)
    end
  end
end
