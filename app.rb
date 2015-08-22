require 'telegram/bot'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # contains database configuration
Dir[File.dirname(__FILE__) + '/app/*'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/models/*'].each {|file| require file }
require 'pry'

class TelegramBotApp
  Telegram::Bot::Client.run(ENV["BASEMENT_BOT_TOKEN"]) do |bot|
    mp = Bot::MidPoint.new bot
    giphy = Bot::Gif.new bot

    bot.listen do |message|
      chat_id = message.chat.id
      username = message.from.username

      case message.text
      when "/goodday"
        bot.api.sendMessage(chat_id: chat_id, text: "Is it a good day?", reply_markup: Keyboards::THUMBS)
      when "/ip"
        bot.api.sendMessage(chat_id: chat_id, text: open('http://whatismyip.akamai.com').read) if username == "nattsw"
      when mp.regex_commands
        mp.execute(message.text, chat_id, username)
      when giphy.regex_commands
        giphy.execute(message.text, chat_id, username)
      when "👍"
        bot.api.sendMessage(chat_id: chat_id, text: "Great!")
      when "👎"
        bot.api.sendMessage(chat_id: chat_id, text: "Why not?")
      else
        unless message.location.nil?
          mp.execute("save_location", chat_id, username, location: message.location)
        end
      end
    end
  end
end
