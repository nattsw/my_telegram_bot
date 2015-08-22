require 'telegram/bot'
require 'sinatra'
require 'sinatra/activerecord'
Dir[File.dirname(__FILE__) + '../models/*'].each {|file| require file }
require 'pry'

module Bot
  class BaseBot
    attr_accessor :bot
    def initialize(bot)
      @bot = bot
      @commands = {}
    end

    def register_command(command_string, action)
      @commands[command_string] = action unless command_string.empty?
    end

    def regex_commands
      Regexp.union(@commands.keys.map { |k| "/" + k })
    end

    def execute(input, chat_id, username, opts={})
      command = get_command(input)
      opts[:text] = get_argument(input)
      if @commands.has_key?(command)
        @commands[command][chat_id, username, opts]
      end
    end

    private
    def get_command(input)
      command = input.partition(" ").first
      command.slice! "/"
      command
    end

    def get_argument(input)
      input.partition(" ").last
    end

    def send_message(chat_id, text)
      bot.api.sendMessage(chat_id: chat_id, text: text)
    end

    def send_document(chat_id, document)
      bot.api.sendDocument(chat_id: chat_id, document: document)
    end

    def send_location(chat_id, lat, lng)
      bot.api.sendLocation(chat_id: chat_id, latitude: lat, longitude: lng)
    end

    def send_busy(chat_id, action)
      bot.api.sendChatAction(chat_id: chat_id, action: action)
    end
  end
end
