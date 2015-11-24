class Admin::ItemsController < Admin::BaseController

def new
    @items = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      flash[:errors] = "Missing fields. Please try again."
      redirect_to new_admin_item_path
    end
  end

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find_by(slug: params[:slug])
  end

  def update
    @item = Item.find_by(slug: params[:slug])
    @item.update(item_params)
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id, :slug)
  end

end
