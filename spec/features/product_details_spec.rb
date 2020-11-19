require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail page", type: :feature, js: true do
 
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

  scenario "They see the product detail" do
    # ACT
    visit root_path

    # DEBUG
    # commented out b/c it's for debugging only
    # save_screenshot 'homepage-test.png'

    # Click on the first link with 'Details' as content
    # first(:link, 'Details').click
    
    # Click on the first product link
    # first('header > a').click

    # Click on the header link that links to products/3
    find("header > a[href='/products/3']").trigger("click")
    

    # commented out b/c it's for debugging only (add sleep to wait a new page to be rendered)
    # sleep 1
    # save_screenshot 'product-detail.png'

    # VERIFY
    expect(page).to have_css 'section.products-show'
  end
end
