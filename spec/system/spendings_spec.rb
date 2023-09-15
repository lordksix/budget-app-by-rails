RSpec.describe 'Spending', type: :system do
  include Devise::Test::IntegrationHelpers
  before(:all) do
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
                                 amount: 9999.9)
    @category1.spendings << @spending1
  end

  before(:each) do
    sign_in @user
  end

  it 'renders correctly index page' do
    visit spendings_path
    expect(page).to have_content('Expenses')
  end

  it 'renders transactions in index page' do
    visit spendings_path
    expect(page).to have_content('Test Trans')
  end

  it 'renders total amount of the transactions created' do
    visit spendings_path
    expect(page).to have_content('9999.9')
  end

  it 'create correctly a new category' do
    visit spendings_path
    click_link 'Add New Transaction'

    fill_in 'Name', with: 'Cat Test'
    fill_in 'Amount', with: '500'
    check('Test Cat', allow_label_click: true)
    click_button 'Save'

    expect(page).to have_content('Transaction was successfully created.')
  end

  it 'renders Show page correctly' do
    visit spendings_path
    click_link 'Test Trans'
    expect(page).to have_content('See all your transactions')
  end

  def delete_all
    Spending.delete_all
    Group.delete_all
    User.delete_all
  end
end
