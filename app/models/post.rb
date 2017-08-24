class Post < ApplicationRecord
    acts_as_votable
    resourcify
    belongs_to :user
    has_many :comments, dependent: :destroy
end
