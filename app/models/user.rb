class User < ApplicationRecord
  has_many :groups, foreign_key: 'user_id', dependent: :destroy
  has_many :spendings, foreign_key: 'author_id', dependent: :destroy
end
