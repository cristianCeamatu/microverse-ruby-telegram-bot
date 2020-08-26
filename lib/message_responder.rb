require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def respond
    on '/start' do
      answer_with_greeting_message
    end

    on '/stop' do
      answer_with_farewell_message
    end
  end
