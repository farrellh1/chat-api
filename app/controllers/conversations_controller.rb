class ConversationsController < ApplicationController
    before_action :set_recipient, only: [:show]

    def index
        conversations = Conversation.where("sender_id = ? OR recipient_id = ?", @current_user.id, @current_user.id).order(updated_at: :desc)
        conversations.each do |conversation|
            conversation[:last_message] = conversation.messages.last
            conversation[:unread] = unread_messages(conversation, @current_user.id).length
        end
        json_response(conversations)
    end

    def show
        conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", @current_user.id, @recipient.id, @recipient.id, @current_user.id).first
        
        messages = conversation.messages.order(created_at: :desc)
        unread_messages = unread_messages(conversation, @current_user.id)
        unread_messages.update_all(read: true)

        json_response(messages)
    end

    private

    def set_recipient
        @recipient = User.find(params[:id])
    end

    def unread_messages(conversations, user_id)
        conversations.messages.where.not(user_id: user_id).where(read: false)
    end
end
