class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    unless self.id == user_id.to_i
      relationships.create(followed_id: user_id)
    end
  end

  def unfollow(user_id)
    unless self.id == user_id.to_i
      relationships.find_by(followed_id: user_id).destroy
    end
  end

  def following?(user)
    unless self.id == user.id
      followings.include?(user)
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
