require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "`that you can add items to the order`" do

    current_user = User.create(username:'jhun', password: 'dana')

    drink1 = Item.create(title:"drip", description: 'yum', price: 4, image:'google.com')

    cart = Cart.new({})

    cart.add_item(drink1.id)


    order = Order.new({user_id: 1, sum: 2, quantity: 1, status: 0})

    order.add_items_to_order(cart, current_user)

    assert_equal({"#{drink1.id}"=>1}, order.add_items_to_order(cart,current_user))
  end
end
