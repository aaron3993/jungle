require 'rails_helper'

RSpec.feature "Users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product they clicked" do
    # ACT
    visit root_path

    click_on('Details', match: :first)

    # DEBUG
    save_screenshot('product.png')

    # VERIFY
    expect(page).to have_css 'img', count: 1
  end
end