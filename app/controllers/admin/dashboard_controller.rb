class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  def show
    @products_count = Product.count
    @categories_count = Category.count
    @products_per_category = Category.order(name: :asc).select(:id, :name).distinct.map do |category|
      {id: category[:id], name: category[:name], count: category.products.count}
  end
end
