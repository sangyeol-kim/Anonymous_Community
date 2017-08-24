class Message < ApplicationRecord
  belongs_to :user
  belongs_to :anonymous_room
  validates :message, presence: true, length: {minimum: 2, maximum: 1000}
  
  def timestamp
    created_at.strftime('%Y-%m-%d %H:%M')
  end
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
