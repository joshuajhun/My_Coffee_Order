require 'test_helper'

class UnregisteredUserCanAddItemsToCartTest < ActionDispatch::IntegrationTest

  test 'unregistered user can add items to cart' do
    create_category_and_items(2)
    item1 = Item.find_by(title: "pour over1")
    item2 = Item.find_by(title: "drip1")
    visit items_path

    within("#item#{item1.id}") do
      find_button("Add to Cart").click
    end
    within("#item#{item2.id}") do
      find_button("Add to Cart").click
    end

    click_button "View Cart"
    assert cart_path, current_path

    within("#item#{item1.id}") do
      assert page.has_content?("pour over")
      assert page.has_content?("it taste really good")
      assert page.has_content?("$4.00")
    end
    within("#order_total") do
      assert page.has_content?("$8.00")
    end
  end

  test 'unregistered user can add the same item multiple time to the cart' do
    create_category_and_items(2)
    item1 = Item.find_by(title: "pour over1")
    visit items_path

    within("#item#{item1.id}") do
      find_button("Add to Cart").click
    end
      click_button "View Cart"

    within("#item#{item1.id}") do
      assert page.has_content?("$4.00")
      assert page.has_content?("1")
    end

    visit items_path

    within("#item#{item1.id}") do
      find_button("Add to Cart").click
    end

    click_button "View Cart"

    within("#item#{item1.id}") do
      assert page.has_content?("2")
    end
    within("#order_total") do
      assert page.has_content?("$8.00")
    end
  end

end
