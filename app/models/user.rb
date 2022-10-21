class User < ApplicationRecord
  has_secure_password
  has_many :conversations, foreign_key: 'sender_id'
  has_many :conversations, foreign_key: 'recipient_id'
  has_many :messages
  validates_presence_of :name, :email, :password_digest
end
