RSpec.describe 'Groups', type: :system do
  include Devise::Test::IntegrationHelpers
  before(:all) do
    delete_all
    @user = User.create!(
      name: 'pepe',
      email: 'john.doe@mail.com',
      password: 'abcdef'
    )
    @category1 = Group.create(user: @user,
                              name: 'Test Cat',
                              icon: 'https://placehold.co/70x70')
    @spending1 = Spending.create(author: @user,
                                 name: 'Test Trans',
                                 amount: 9999.9)
    @category1.spendings << @spending1
  end

  before(:each) do
    sign_in @user
  end

  it 'renders page title for user in index page' do
    visit groups_path
    expect(page).to have_content('Categories')
  end

  it 'renders users catergory' do
    visit groups_path
    expect(page).to have_content('Test Cat')
  end

  it 'renders total amount of the category created' do
    visit groups_path
    expect(page).to have_content('9999.9')
  end

  it 'create correctly a new category' do
    visit groups_path
    click_link 'Add New Category'

    fill_in 'Name', with: 'Cat Test'
    fill_in 'Icon URL', with: 'https://placehold.co/70x70'

    click_button 'Save'

    expect(page).to have_content('Category was successfully created.')
  end

  it 'renders Show page correctly' do
    visit groups_path
    click_link 'Test Cat'
    expect(page).to have_content('Test Cat')
  end

  def delete_all
    Spending.delete_all
    Group.delete_all
    User.delete_all
  end
end
