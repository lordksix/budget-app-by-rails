class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :spendings

  validates :name, presence: { message: "can't be blank" },
                   length: { maximum: 100, message: 'is too long. Max: 100 characteres' }

  before_save :update_total_spending

  def update_total_spending
    self.total_spending = spendings.reduce(0.0) do |acc, item|
      p item.amount
      acc + item.amount
    end
  end
end
