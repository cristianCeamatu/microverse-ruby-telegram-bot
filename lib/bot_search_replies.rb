require_relative '../lib/search'

module BotSearchReplies
  # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
  def search_wiki_response(bot, message, gif)
    search = Search.new
    query = search.get_query_from_message(message.text)

    if query.downcase == 'random'
      bot.api.send_message(chat_id: message.chat.id, text: 'I will give you 3 random wikipedia results:')
      search.results('wiki-random', search.uri('wiki', nil)).each do |el|
        sleep 1
        bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el[:title]}")
      end
    elsif search.check_query(query) == query.strip
      bot.api.send_message(chat_id: message.chat.id, text: "You are searching on Wikipedia for `#{query}`!")
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'I will give you maximum 3 wikipedia results:')
      sleep 1

      response = search.results('wiki-search', search.uri('wiki', query.strip))
      if response.is_a?(String)
        bot.api.send_message(chat_id: message.chat.id, text: response)
      else
        response.each do |el|
          bot.api.send_message(chat_id: message.chat.id, text: "https://en.wikipedia.org/wiki/#{el[:title]}")
          sleep 1
        end
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: search.check_query(query))
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    end
  end

  def search_google_response(bot, message, gif)
    search = Search.new
    query = search.get_query_from_message(message.text)

    if search.check_query(query) == query.strip
      bot.api.send_message(chat_id: message.chat.id, text: "You are searching on Google Websites for `#{query}`!")
      sleep 1
      bot.api.send_message(chat_id: message.chat.id, text: 'I will give you maximum 3 Google results:')
      sleep 1
      response = search.results('google', search.uri('google', query.strip))

      if response.is_a?(String)
        bot.api.send_message(chat_id: message.chat.id, text: response)
      else
        response.each do |el|
          bot.api.send_message(chat_id: message.chat.id, text: el[:link])
          sleep 1
        end
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: search.check_query(query))
      bot.api.send_animation(chat_id: message.chat.id, animation: gif) if gif
    end
  end
  # rubocop: enable Metrics/MethodLength, Metrics/AbcSize
end
