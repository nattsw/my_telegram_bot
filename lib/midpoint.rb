require 'telegram/bot'

class MidPoint
  COMMANDS = ["/resetloc","/midpoint"]

  def initialize(bot)
    @chats = {}
    @bot = bot
  end

  def self.commands
    Regexp.union(COMMANDS)
  end

  def register(command, action)

  end

  def execute(command, chat_id, username)
    case command
    when "/resetloc"
      if @chats.has_key?(chat_id) && @chats[chat_id].has_key?(username)
        @chats[chat_id].delete(username)
      end
      @bot.api.sendMessage(chat_id: chat_id, text: "#{username}'s location is reset")
    when "/midpoint"
      if @chats.has_key?(chat_id) && @chats[chat_id].count > 0
        count = 0
        lat = 0
        lng = 0
        @chats[chat_id].values.each do |u|
          count += 1
          lat += u[:lat]
          lng += u[:lng]
        end
        lat /= count
        lng /= count
        @bot.api.sendMessage(chat_id: chat_id, text: "The centre point is #{lat}, #{lng}")
        @bot.api.sendLocation(chat_id: chat_id, latitude: lat, longitude: lng)
      else
        @bot.api.sendMessage(chat_id: chat_id, text: "No locations set")
      end
    end
  end

  def save_location(location)
    lat = location.latitude
    lng = location.longitude
    @chats[chat_id] = {} unless @chats.has_key?(chat_id)
    @chats[chat_id][username] = { lat: lat, lng: lng }
    @bot.api.sendMessage(chat_id: chat_id, text: "Your location has been saved: #{lat}, #{lng}")
  end
end
