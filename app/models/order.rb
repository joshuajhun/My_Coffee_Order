class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  validates :sum, presence: true

  enum status: [ :ordered, :paid, :cancelled, :completed ]

  def find_subtotal(item_id, quantity)
    Item.find(item_id).price * quantity
  end

  def add_items_to_order(cart, current_user)
    cart.contents.each do |item_id, quantity|
      subtotal = find_subtotal(item_id, quantity)
      OrderItem.create(order_id: self.id, item_id: item_id.to_i, quantity: quantity, subtotal: subtotal)
    end
  end

 def quantity_of_item(item_id)
  self.order_items.find_by(item_id: item_id).quantity
 end

 def subtotal_of_item(item_id)
   self.order_items.find_by(item_id: item_id).subtotal
 end

end
