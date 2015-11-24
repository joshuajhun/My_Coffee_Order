require 'test_helper'

class AdminEditsItemTest < ActionDispatch::IntegrationTest

  test 'admin can edit an item' do

    create_category_and_items(1)
    logged_in_admin

    visit admin_items_path

    item1 = Item.find_by(title: 'pour over0')
    within "#item#{item1.id}" do
      find_button('Edit Item').click
    end

    assert admin_edit_item_path(item1.id), current_path

    fill_in 'Title', with: 'Updated Title'
    fill_in 'Description', with: 'Updated Description'
    fill_in 'Price', with: '3'
    fill_in 'Image', with: 'blankImage.com'
    click_button('Update Item')
    item_to_check = Item.find_by(title: 'Updated Title')

      refute page.has_content?('pour over0')
      assert page.has_content?('Updated Title')
      refute page.has_content?('it taste really good')
      assert page.has_content?('Updated Description')

      assert page.has_content?('$3.00')


  end
end
