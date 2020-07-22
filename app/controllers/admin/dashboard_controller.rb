class Admin::DashboardController < ApplicationController
  def show
    @count_products = Product.count
    @count_categories = Category.count
  end

  # def count
  # end
end
