class Admin::DashboardController < Admin::BaseController

  def index
    @admin = current_user
    @orders = Order.all
  end
end
