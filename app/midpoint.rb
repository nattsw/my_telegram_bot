module Bot
  class MidPoint < BaseBot
    def initialize(bot)
      super bot
      @chats = {}
      @bot = bot
      register_command("resetloc", reset_action)
      register_command("midpoint", midpoint_action)
      register_command("save_location", save_location)
    end

    private
    def reset_action
      lambda { |chat_id, username, opts|
        if @chats.has_key?(chat_id) && @chats[chat_id].has_key?(username)
          @chats[chat_id].delete(username)
        end
        send_message(chat_id, "#{username}'s location is reset")
      }
    end

    def midpoint_action
      lambda { |chat_id, username, opts|
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
          send_message(chat_id, "The centre point is #{lat}, #{lng}")
          send_location(chat_id, lat, lng)
        else
          send_message(chat_id, "No locations set")
        end
      }
    end

    def save_location
      lambda { |chat_id, username, opts|
        lat = opts[:location].latitude
        lng = opts[:location].longitude
        @chats[chat_id] = {} unless @chats.has_key?(chat_id)
        @chats[chat_id][username] = { lat: lat, lng: lng }
        send_message(chat_id, "Your location has been saved: #{lat}, #{lng}")
      }
    end
  end
end
