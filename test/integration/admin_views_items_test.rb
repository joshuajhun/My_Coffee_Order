require 'test_helper'

class AdminViewsItemsTest < ActionDispatch::IntegrationTest
  test 'admin can view items' do
    create_category_and_items(1)
    # As an Admin
    logged_in_admin
    #   When I visit "/admin/dashboard"
    visit '/admin/dashboard'
    assert admin_dashboard_index_path, current_path
    #   Then I should see a link for viewing all items
    save_and_open_page
    click_link('View items')
    #   And when I click that link
    #   Then my current path should be "/admin/items"
    assert '/admin/items', current_path
    #   Then I should see a table with all items (active and inactive)

    assert page.has_content?('pour over0')
    assert page.has_content?('it taste really good')
    # NEED TO ADD assert page.has_content?('Status')
    #   And each item should have:
    #     - A thumbnail of the image
    #     - Title that links to the item
    #     - Description
    #     - Status
    item1 = Item.find_by(title: "pour over0")
    within "#item#{item1.id}" do
      find_button('Edit Item').click
    end
    #     - Actions (Edit)
  end
end

# admin = logged_in_admin
# #   When I visit "/admin/dashboard"
# ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
# assert "/admin/dashboard", current_path
# assert page.has_content?("Admin's Dashboard")
