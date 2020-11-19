class Admin::DashboardController < ApplicationController
  
  include HttpAuthConcern

  def show
    @products_count = Product.count
    @categories_count = Category.count
    @products_per_category = Category.order(name: :asc).select(:id, :name).distinct.map do |category|
      {id: category[:id], name: category[:name], count: category.products.count}
    end
  end
end
