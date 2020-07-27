require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do
    @category = Category.new
    @product = @category.products.new
  end
  it "should be created with all four fields defined" do
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = 2
    @product.save
    expect(@product).to be_valid
  end
  it "should not be created with nil as quantity" do
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = nil
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end
end

# Each example (it) is run in isolation of others. Therefore each example will needs its own @category created and then @product initialized with that category
# Create an initial example that ensures that a product with all four fields set will indeed save successfully
# Have one example for each validation, and for each of these:
# Set all fields to a value but the validation field being tested to nil
# Test that the expect error is found within the .errors.full_messages array
# You should therefore have five examples defined given that you have the four validations above