class AnonymousRoom < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :messages, dependent: :destroy
end
