class CreateGroupChatsUsers < ActiveRecord::Migration
  def change
    create_table :group_chats_users do |t|
      t.belongs_to :group_chat, index: true
      t.belongs_to :user, index: true
    end
  end

  def down
    drop_table :group_chats_users
  end
end
