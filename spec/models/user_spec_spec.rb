require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  it "should not be logged in if password and password_confirmation fields don't match" do
    @user = User.new
    @product = @category.products.new
    @product.name = "Book"
    @product.price = 2000
    @product.quantity = 2
    @product.save
    expect(@product).to be_valid
  end
end

# It must be created with a password and password_confirmation fields
# These need to match so you should have an example for where they are not the same
# These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
# Email, first name, and last name should also be required