require 'telegram/bot'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # contains database configuration

class TelegramBotApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end
end
