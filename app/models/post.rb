class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :User
    # postsがuserを1つもつ
    has_many :comments, dependent: :destroy
end
