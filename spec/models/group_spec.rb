require_relative '../rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create!(name: 'user 1', email: 'emailtest@email.com', password: 'abcdef') }
  let(:group) { user.groups.create!(name: 'category test', icon: 'https://placehold.co/70x70') }

  describe 'validation' do
    it 'requires name to be present' do
      group.name = nil
      expect(group).not_to be_valid
    end

    it 'requires icon to be present' do
      group.icon = nil
      expect(group).not_to be_valid
    end
  end
end
