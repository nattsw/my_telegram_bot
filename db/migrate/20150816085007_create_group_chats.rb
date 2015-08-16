class CreateGroupChats < ActiveRecord::Migration
  def change
    create_table :group_chats do |t|
      t.string :title
    end
  end

  def down
    drop_table :group_chats
  end
end
