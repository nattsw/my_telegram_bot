require 'telegram/bot'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # contains database configuration
Dir[File.dirname(__FILE__) + '/lib/*'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/models/*'].each {|file| require file }


class TelegramBotApp < Sinatra::Base

  get '/' do
    "Hello, world!"
  end

  Telegram::Bot::Client.run(ENV["BASEMENT_BOT_TOKEN"]) do |bot|
    bot.listen do |message|
      chat_id = message.chat.id
      username = message.from.username

      case message.text
      when "/goodday"
        bot.api.sendMessage(chat_id: message.chat.id, text: "Is it a good day?", reply_markup: Keyboards::THUMBS)
      when "/ip"
        bot.api.sendMessage(chat_id: chat_id, text: open('http://whatismyip.akamai.com').read) if username == "nattsw"
      when MidPoint.commands
        mp ||= MidPoint.new bot
        mp.execute(message.text, chat_id, username)
      when Gif.commands
        giphy ||= Gif.new bot
        giphy.execute(message.text, chat_id, username)
      when "👍"
        bot.api.sendMessage(chat_id: message.chat.id, text: "Great!")
      when "👎"
        bot.api.sendMessage(chat_id: message.chat.id, text: "Why not?")
      else
        unless message.location.nil?
          mp ||= MidPoint.new bot
          mp.execute(message.text)
        end
      end
    end
  end
end
