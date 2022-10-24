class MessagesController < ApplicationController
  def create
    conversation = Conversation.show_messages(@current_user.id, params[:recipient_id])

    if conversation.nil?
      conversation = Conversation.create!(sender_id: @current_user.id, recipient_id: params[:recipient_id])
    end

    message = Message.create!(user_id: @current_user.id, conversation_id: conversation.id, body: params[:body])

    conversation.update!(updated_at: message.created_at)
    json_response(message)
  end
end
