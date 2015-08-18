class Message < ActiveRecord::Base
  belongs_to :chat, polymorphic: true
  has_and_belongs_to_many :users
  has_many :messages, as: :chat
end
