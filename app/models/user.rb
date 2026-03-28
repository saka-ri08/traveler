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

  # フォローしている関係（自分 → 相手）
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy

  # フォローされている関係（相手 → 自分）
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  
  # フォローしているユーザー一覧
  has_many :following, through: :relationships, source: :followed

  # フォロワー一覧
  has_many :followers, through: :reverse_relationships, source: :follower

  has_one_attached :profile_image

  # ユーザーをフォローする
  def follow(user_id)
   relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
   relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
   following.include?(user)
  end

end
