class User < ActiveRecord::Base
  has_and_belongs_to_many :group_chats
  has_many :messages, as: :chat
end
