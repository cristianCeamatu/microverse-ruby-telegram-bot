module BotCommandReplies
  def start_response(bot, message, gif)
    bot.api.send_message(chat_id: message.chat.id, text: 'Did somebody call the Master Search bot?')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: "Was that you #{message.from.first_name}?")
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: 'Have questions? I have the answers!')
    sleep 1
    bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: "Available searches:\nsearch wiki <and some text>\nsearch wiki random(get 3 random results)\nsearch google <and some text>(search Google websites)") # rubocop: disable Layout/LineLength
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: 'Available commands: /start /stop /help')
  end

  def stop_response(bot, message, gif)
    bot.api.send_message(chat_id: message.chat.id, text: 'You can never stop me!')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '<b>I know who you are and where you live!!!</b>', parse_mode: 'HTML') # rubocop: disable Layout/LineLength
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: "<b>#{message.from.first_name}!!!</b>", parse_mode: 'HTML')
    sleep 1
    bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
  end

  def help_response(bot, message, gif)
    bot.api.send_message(chat_id: message.chat.id, text: 'Want to know what I can do?')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '`/start` to get a nice Gif and a greetings message')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '`/stop` to get a bad Gif and a Bye Bye message')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '`search wiki <and some text>` to search Wikipedia')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '`search wiki random` (get 3 random Wikipedia results)')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: '`search google <and some text>` to search trough all Google Websites (not a google search)') # rubocop: disable Layout/LineLength
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: 'Don`t be shy, just try!')
    sleep 1
    bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
  end

  def random_text_response(bot, message, gif)
    bot.api.send_message(chat_id: message.chat.id, text: "Why you wrote `#{message.text}`")
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: 'You need to write one of the following commands:')
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: "Available searches:\nsearch wiki <and some text>\nsearch wiki random(get 3 random results)\nsearch google <and some text>(search Google websites)") # rubocop: disable Layout/LineLength
    sleep 1
    bot.api.send_message(chat_id: message.chat.id, text: 'Available commands: /start /stop /help')
    sleep 1
    bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
  end
end
