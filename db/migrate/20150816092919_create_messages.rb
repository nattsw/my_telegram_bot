class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :message_id
      t.belongs_to :user, foreign_key: 'from', index: true
      t.datetime :date
      t.belongs_to :group_chats_user, foreign_key: 'chat', index:true
      t.belongs_to :user, foreign_key: 'forward_from'
      t.integer :forward_date
      t.belongs_to :message, foreign_key: 'reply_to_message'
      t.string :text
      t.boolean :audio
      t.boolean :document
      t.boolean :photo
      t.boolean :sticker
      t.boolean :video
      t.boolean :voice
      t.string :caption
      t.boolean :contact
      t.references :location
      t.belongs_to :user, foreign_key: 'new_chat_participant'
      t.belongs_to :user, foreign_key: 'left_chat_participant'
      t.string :new_chat_title
      t.boolean :new_chat_photo
      t.boolean :delete_chat_photo
      t.boolean :group_chat_created
    end
  end

  def down
    drop_table :messages
  end
end
