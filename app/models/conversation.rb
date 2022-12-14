class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :user, foreign_key: 'recipient_id', class_name: 'User'
  has_many :messages
  attribute :last_message
  attribute :unread

  scope :show_conversations, lambda { |sender_id|
                               where('sender_id = ? OR recipient_id = ?', sender_id, sender_id).order(updated_at: :desc)
                             }
  def self.show_messages(sender_id, recipient_id)
    where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)',
          sender_id, recipient_id, recipient_id, sender_id).first
  end
end
