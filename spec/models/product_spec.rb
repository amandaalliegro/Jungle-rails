require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.create(name: 'Games')
    end

    it 'saves successfully when all fields are set' do
      @product = Product.new(
        name: 'Catan', 
        price: 100, 
        quantity: 20, 
        category_id: @category[:id]
      )
      @product.save
      expect(Product.all).to include(@product)
    end

    it 'returns an error when the name is blank' do
      @product = Product.new(
        name: nil, 
        price: 100, 
        quantity: 20, 
        category_id: @category[:id]
      )
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'returns an error when the price is blank' do
      @product = Product.new(
        name: 'Catan', 
        price: nil, 
        quantity: 20, 
        category_id: @category[:id]
      )
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'returns an error when the quantity is blank' do
      @product = Product.new(
        name: 'Catan', 
        price: 100, 
        quantity: nil, 
        category_id: @category[:id]
      )
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'returns an error when the category_id is blank' do
      @product = Product.new(
        name: 'Catan', 
        price: 100, 
        quantity: 20, 
        category_id: nil
      )
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")

    end

  end
end