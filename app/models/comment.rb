class Comment < ApplicationRecord
    belongs_to :User
    belongs_to :post

    validates :comment, presence: true, length: { maximum: 35 }
end
