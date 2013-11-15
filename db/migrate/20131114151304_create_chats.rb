class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :phrase
      t.integer :user_id
      t.integer :key_id
    end
  end
end
