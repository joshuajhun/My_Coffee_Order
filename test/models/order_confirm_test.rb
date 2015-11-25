require 'test_helper'

class OrderConfirmTest < ActiveSupport::TestCase
  test 'class validates order' do
    current_user = User.create(username:'jhun', password: 'dana')

    drink1 = Item.create(title:"drip", description: 'yum', price: 4, image:'google.com')

    cart = Cart.new({})

    cart.add_item(drink1.id)


    order = Order.new({user_id: "#{current_user.id}", sum: 2, quantity: 1, status: 0})

    OrderConfirm.validate(cart, current_user, order)

    assert_equal({}, OrderConfirm.validate(cart, current_user, order))
  end

  test "class denies order" do
    current_user = nil
    drink1 = Item.create(title:"drip", description: 'yum', price: 4, image:'google.com')

    cart = Cart.new({})

    cart.add_item(drink1.id)


    order = Order.new({user_id: nil, sum: 2, quantity: 1, status: 0})

    OrderConfirm.validate(cart, current_user,  order)

    assert_equal(nil, OrderConfirm.validate(cart, current_user, order))
  end
end
