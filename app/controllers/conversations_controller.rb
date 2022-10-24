class ConversationsController < ApplicationController
  before_action :set_recipient, only: [:show]

  def index
    conversations = Conversation.show_conversations(@current_user.id)
    conversations.each do |conversation|
      conversation[:last_message] = conversation.messages.last
      conversation[:unread] = unread_messages(conversation, @current_user.id).length
    end
    json_response(conversations)
  end

  def show
    conversation = Conversation.show_messages(@current_user.id, @recipient.id)

    messages = conversation.messages.order(created_at: :desc).page params[:page]
    unread_messages = unread_messages(conversation, @current_user.id)
    unread_messages.update_all(read: true)

    json_response(messages)
  end

  private

  def set_recipient
    @recipient = User.find(params[:id])
  end

  def unread_messages(conversations, user_id)
    conversations.messages.where.not(user_id:).where(read: false)
  end
end
