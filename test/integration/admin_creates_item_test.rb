require 'test_helper'

class AdminCreatesItemTest < ActionDispatch::IntegrationTest
  # As an authenticated Admin:
  test 'admin can create an item' do
  #       I can create an item.
    Category.create(name:"Coffee")
    logged_in_admin
    visit admin_dashboard_index_path
    click_link('Add New Item')

    assert new_admin_item_path, current_path

    fill_in('Title', with: 'New Item')
    fill_in('Description', with: 'Rad Description of new item')
    fill_in('Price', with: '3')
    fill_in('Image URL', with: 'www.google.com')

    select:"Coffee", from: "item_category_id"
    find_button('Create Item').click

    assert admin_items_path, current_path


    assert page.has_content?("New Item")
    assert page.has_content?("Rad Description of new item")
    assert page.has_content?("$3.00")
    assert page.has_css?('img')
  end

  test 'admin must have certain fields or errors will flash' do
    Category.create(name:"Coffee")
    logged_in_admin
    visit admin_dashboard_index_path
    click_link('Add New Item')

    assert new_admin_item_path, current_path

    fill_in('Title', with: '')
    fill_in('Description', with: '')
    fill_in('Price', with: '')
    fill_in('Image URL', with: 'www.google.com')
    select "Coffee", from: "Category ID"
    find_button('Create Item').click

    assert page.has_content?("Missing fields")

  end
end
