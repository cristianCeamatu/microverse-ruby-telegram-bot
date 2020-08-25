require_relative './utils'

class Random
  include Utils

  attr_reader :loading_message

  def initialize
    @loading_message = 'Wait while I use my super powers to give you a random article.' \
    'I could return the result instantly but counters make me feel important :D'
  end
end
