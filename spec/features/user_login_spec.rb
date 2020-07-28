require 'rails_helper'

RSpec.feature "Users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      first_name: "a",
      last_name: "a",
      email: "a",
      password: "aaa",
      password_confirmation: "aaa"
    )
  end

  scenario "They are redirected to home page upon successful login" do
    # ACT
    visit login_path

    fill_in 'email', with: @user.email

    fill_in 'password', with: @user.password

    click_button "Submit"
    
    # DEBUG
    save_screenshot('user.png')

    # VERIFY
    expect(page).to have_content('Logout')
  end
end