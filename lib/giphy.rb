require 'telegram/bot'
require 'giphy'
require 'open-uri'

require 'pry'

class Gif
  COMMANDS = ["/gif"]

  def initialize(bot)
    @bot = bot
  end

  def self.commands
    Regexp.union(COMMANDS)
  end

  def register(command, action)

  end

  def execute(command, chat_id, username)
    gif = command[4..-1]
    unless gif.empty?
      result = Giphy.random(gif)
      url = result.image_url.to_s
      unless (result.nil? && url[-4..-1] != ".gif")
        tmp = open(url)
        def tmp.original_filename; "foo.gif"; end
        @bot.api.sendDocument(chat_id: chat_id, document: tmp)
      end
    end
  end
end
