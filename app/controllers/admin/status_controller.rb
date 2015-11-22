class Admin::StatusController < ApplicationController

  def index
    @orders = Order.where(status: params[:status].to_i)
  end
end
