class Post < ApplicationRecord
    paginates_per 14
    acts_as_votable
    resourcify
    belongs_to :user
    has_many :comments, dependent: :destroy
end
