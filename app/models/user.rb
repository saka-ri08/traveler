class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  # ユーザーが複数ポストを持つ(has_many :posts)
  # ユーザーが削除されたら、紐づいているpostも削除する
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  # followerテーブルからfollowedをソースとし、フォローしているユーザーリストを定義
  # followedテーブルからfollowerをソースとし、フォローされているユーザーリストを定義

  has_one_attached :profile_image

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end 
end
