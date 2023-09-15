require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  include Devise::Test::IntegrationHelpers
  before(:all) do
    delete_all
    @user = User.create!(
      name: 'pepe',
      email: 'john.doe@mail.com',
      password: 'abcdef'
    )
  end

  it 'renders correctly' do
    visit root_path
    expect(page).to have_content('Budget App')
  end

  it 'renders sign in options for unsigned user' do
    visit root_path
    expect(page).to have_content('Sign in')
  end

  it 'renders continue button for signed user' do
    sign_in @user
    visit root_path
    expect(page).to have_content('Continue')
  end

  def delete_all
    Spending.delete_all
    Group.delete_all
    User.delete_all
  end
end
