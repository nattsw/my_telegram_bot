require 'telegram/bot'

class Keyboards
  THUMBS ||= Telegram::Bot::Types::ReplyKeyboardMarkup .new(keyboard: [%w(👍 👎)], one_time_keyboard: true, selective: true)
  ABCD ||= Telegram::Bot::Types::ReplyKeyboardMarkup .new(keyboard: [%w(A B), %w(C D)], one_time_keyboard: true, selective: true)
end
