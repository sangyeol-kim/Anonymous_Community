class User < ApplicationRecord
  acts_as_voter
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :posts
  has_many :anonymous_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :comments
  validates_uniqueness_of :nickname
  
  def name
    email.split('@')[0]
  end
end
