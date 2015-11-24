class OrdersController < ApplicationController

  before_action :require_authenticated_user

   def require_authenticated_user
     redirect_to login_path unless current_user
     flash[:login] ="Must Login"
   end

  def create
    @order = Order.new(quantity: params[:quantity] , sum: params[:sum] )
    OrderConfirm.validate(@cart, current_user, @order)
    flash[:order] = "Order was succefully placed"
    redirect_to orders_path
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
