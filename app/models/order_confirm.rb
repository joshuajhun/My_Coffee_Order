class OrderConfirm

  def self.validate(cart, current_user, order)
    if order.save && current_user
      current_user.orders << order
      order.add_items_to_order(cart, current_user)
      order.ordered!
      cart.contents.clear
      SendMessage.text
    end
  end
end
