require 'sinatra'
require 'sinatra/activerecord'

class TelegramBotApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end
end
