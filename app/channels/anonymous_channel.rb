class AnonymousChannel < ApplicationCable::Channel
  def subscribed
    stream_from "anonymous_rooms_#{params['anonymous_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(message: data['message'], anonymous_room_id: data['anonymous_room_id'])
  end
end