class User < ActiveRecord::Base
  has_many :keys
  has_many :chats

end
