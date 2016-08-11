# frozen_string_literal: true
module Api
  module V1
    # Api::V1::ConversationsController
    class ConversationsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_conversation, only: [:show, :reply]

      def index
        conversations = current_api_v1_user.mailbox.conversations
        render json: conversations, status: :ok
      end

      def show
        @conversation.mark_as_read current_api_v1_user
        render json: @conversation, serializer: ConversationSerializer, user: current_api_v1_user, status: :ok
      end

      def sent
        recipients = User.where(id: conversation_params[:recipients])
        conversation = current_api_v1_user.send_message(recipients, conversation_params[:body], 'Subject').conversation
        render json: conversation, serializer: ConversationSerializer, user: current_api_v1_user, status: :ok
      end

      def reply
        current_api_v1_user.reply_to_conversation @conversation, message_params[:body]
        render json: @conversation, serializer: ConversationSerializer, user: current_api_v1_user, status: :ok
      end

      private

      def conversation_params
        params.require(:conversation).permit(:body, recipients: [])
      end

      def message_params
        params.require(:message).permit(:body)
      end

      def set_conversation
        @conversation = current_api_v1_user.mailbox.conversations.find(params[:id])
      end
    end
  end
end
