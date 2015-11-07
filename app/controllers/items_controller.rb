class ItemsController < ApplicationController
  def index
    @items = current_user.items.all
  end

  def new
    @item=Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id #Not sure why I use this instead of @user = User.find(params[:id])

    if @item.save
      redirect_to items_path, notice: "Item successfully saved."
    else
      flash[:error] = "Error adding you To Do item.  Please try again."
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :user_id, :status, :expiration)
  end
end
