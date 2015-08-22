require 'telegram/bot'
require 'giphy'
require 'open-uri'

require 'pry'

module Bot
  class Gif < BaseBot
    def initialize bot
      super bot
      register_command("gif", gif_action)
    end

    private
    def gif_action
      lambda { |chat_id, username, opts|
        if !opts.has_key?(:text) || opts[:text].empty?
          argument = "cat"
        else
          argument = opts[:text]
        end
        url = get_gif_url(Giphy.random(argument))
        if url.present?
          send_busy(chat_id, Action::UPLOAD_DOCUMENT)
          tmp = download_gif(url)
          (send_document(chat_id, tmp); tmp.close) unless tmp.nil?
        else
          send_message(chat_id, "We're overloading Giphy! Try again laterrrr?")
        end
      }
    end

    def download_gif(url)
      unless is_gif(url)
        tmp = open(url)
        def tmp.original_filename; "gif.gif"; end
      end
      tmp
    end

    def get_gif_url(result)
      begin
        return result.image_url.to_s
      rescue
        return ""
      end
    end

    def is_gif(url)
      url[-4..-1] != ".gif"
    end
  end
end
