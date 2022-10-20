class Conversation < ApplicationRecord
    belongs_to :user, foreign_key: 'sender_id', class_name: 'User'
    belongs_to :user, foreign_key: 'recipient_id', class_name: 'User'
    has_many :messages
    attribute :last_message
    attribute :unread
end
