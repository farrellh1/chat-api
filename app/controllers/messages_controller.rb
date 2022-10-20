class MessagesController < ApplicationController
    def create
        recipient = User.find(message_params[:recipient_id])
        conversation = Conversation.where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",@current_user.id, message_params[:recipient_id], message_params[:recipient_id], @current_user.id).first

        if conversation.nil?
            conversation = Conversation.create!(sender_id: @current_user.id, recipient_id: message_params[:recipient_id])
        end

        message = Message.create!(user_id: @current_user.id, conversation_id: conversation.id, body: message_params[:body])

        if message.save
            conversation.update!(updated_at: message.created_at)
            json_response(message)
        else
            json_response(message.errors.messages, :unprocessable_entity)
        end
    end

    private

    def message_params
      params.permit(:body, :recipient_id)
    end
end
