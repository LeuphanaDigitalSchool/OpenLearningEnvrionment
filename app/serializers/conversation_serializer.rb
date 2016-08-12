# frozen_string_literal: true
# ConversationSerializer
class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :subject, :messages

  def messages
    object.receipts_for(instance_options[:user]).collect do |r|
      {
        "sender": r.message.sender.display_name,
        "body": r.message.body,
        "created_at": r.message.created_at.strftime('%A, %b %d, %Y at %I:%M%p')
      }
    end
  end
end
