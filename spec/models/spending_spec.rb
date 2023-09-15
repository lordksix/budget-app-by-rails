require_relative '../rails_helper'

RSpec.describe Spending, type: :model do
  let(:user) { User.create!(name: 'user 1', email: 'emailtest@email.com', password: 'abcdef') }
  let(:spending) { user.spendings.create!(name: 'transaction test', amount: 120) }

  describe 'validation' do
    it 'requires name to be present' do
      spending.name = nil
      expect(spending).not_to be_valid
    end

    it 'requires amount to be positive' do
      spending.amount = -2.5
      expect(spending).not_to be_valid
    end
  end
end
