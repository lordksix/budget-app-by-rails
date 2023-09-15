require_relative '../rails_helper'

RSpec.describe Spending, type: :model do
  describe 'validation' do
    before(:each) do
      delete_all
      @user = User.create!(
        name: 'pepe',
        email: 'john.doe@mail.com',
        password: 'admin1234'
      )
      @category1 = Group.create(user: @user,
                                name: 'Test Cat',
                                icon: 'https://placehold.co/70x70')
      @spending1 = Spending.create(author: @user,
                                   name: 'Test Trans',
                                   amount: 9999.9,
                                   groups: [@category1])
    end

    it 'requires name to be present' do
      @spending1.name = nil
      expect(@spending1).not_to be_valid
    end

    it 'requires amount to be positive' do
      @spending1.amount = -2.5
      expect(@spending1).not_to be_valid
    end
  end

  def delete_all
    Spending.delete_all
    Group.delete_all
    User.delete_all
  end
end
