class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :spendings, dependent: :destroy

  validates :name, presence: { message: "can't be blank" },
                   length: { maximum: 100, message: 'is too long. Max: 100 characteres' }
end
