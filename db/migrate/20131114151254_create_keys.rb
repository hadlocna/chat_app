class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.belongs_to :user
      t.string :token
      t.string :use
      t.integer :receiver_id
      t.timestamps
    end
  end
end
