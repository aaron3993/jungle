require 'rails_helper'

RSpec.describe Product, type: :model do
  # before(:all) do
  #   @category = Category.new
  #   @product = @category.products.new
  # end
  it "should be created with all four fields defined" do
    @category = Category.new
    @product = @category.products.new
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = 2
    @product.save
    expect(@product).to be_valid
  end
  it "should not be created with nil as name" do
    @category = Category.new
    @product = @category.products.new
    @product.name = nil
    @product.price = 2000
    @product.quantity = 2
    @product.save
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end
  it "should not be created with nil as price" do
    @category = Category.new
    @product = @category.products.new
    @product.name = "Book"
    @product.price = nil
    @product.quantity = 2
    @product.save
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end
  it "should not be created with nil as quantity" do
    @category = Category.new
    @product = @category.products.new
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = nil
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end
  it "should not be created with nil as category" do
    @category = Category.new
    @product = @category.products.new
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = 2
    @product.category = nil
    @product.save
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end
end