class Message < ActiveRecord::Base
  belongs_to :chat, polymorphic: true
end
