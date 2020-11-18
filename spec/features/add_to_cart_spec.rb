require 'rails_helper'

RSpec.feature "Visitor can add products to cart", type: :feature, js: true do

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

  scenario "The cart quantifier is increased by 1" do
    # ACT
    visit root_path

    # DEBUG
    # commented out b/c it's for debugging only
    # save_screenshot 'homepage-test.png'

    expect(page).to have_content('My Cart (0)')
    # ACT
    first(:button, 'Add').click()

    # DEBUG
    # save_screenshot 'cart(1).png'

    # VERIFY
    expect(page).to have_content('My Cart (1)')

  end

end