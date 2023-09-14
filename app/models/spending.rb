class Spending < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates :name, presence: { message: "can't be blank" },
                   length: { maximum: 100, message: 'is too long. Max: 100 characteres' }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_total_expense

  private

  def update_total_expense
    groups.each(&:save)
  end
end
