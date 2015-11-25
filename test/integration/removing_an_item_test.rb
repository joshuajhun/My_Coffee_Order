require 'test_helper'

class RemovingAnItemTest < ActionDispatch::IntegrationTest
   test "an unregistered user can delete an item from the cart" do
     create_category_and_items(2)
     item1 = Item.find_by(title: "pour over1")
     visit items_path

     within("#item#{item1.id}") do
       find_button("Add to Cart").click
     end
     click_button "View Cart"
     assert page.has_content?("$4.00")
      assert page.has_content?("1")
     click_link "Remove"
     assert page.has_content?("Successfully removed pour over1 from your cart")
   end

   test "when an item hits zero it's gone" do
     create_category_and_items(2)
     item1 = Item.find_by(title: "pour over1")
     visit items_path

     within("#item#{item1.id}") do
       find_button("Add to Cart").click
     end
     click_button "View Cart"
     assert page.has_content?("$4.00")
      assert page.has_content?("1")
     click_button "-"
     refute page.has_content?("pour over1")
   end

   test 'That you can  have multiple items in the cart and remove one item completely from the cart. ' do
     create_category_and_items(2)

     visit items_path

     item1 = Item.find_by(title: "pour over0")
     item2 = Item.find_by(title: "drip0")

     within "#item#{item1.id}" do
       click_button "Add to Cart"
     end

     within "#item#{item2.id}" do
       click_button "Add to Cart"
     end

     click_button "View Cart"

     item_to_check = Item.find_by(title: 'pour over0') do
       click_button "+"
       click_button "-"
       assert page.has_content?("1")
       click_button "-"
       refute page.has_content("pour over0")
     end

     assert page.has_content?('drip0')
   end
end
