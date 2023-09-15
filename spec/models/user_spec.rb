require_relative '../rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'user 1', email: 'emailtest@email.com', password: 'abcdef') }

  describe 'validation' do
    it 'requires name to be present' do
      user.name = nil
      expect(user).not_to be_valid
    end
  end
end
