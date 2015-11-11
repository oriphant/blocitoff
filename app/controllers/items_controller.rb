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

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      redirect_to items_path, notice: "Item updated."
    else
      flash[:error] = "Error updating To Do item.  Please try again."
      render :new
    end
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

  def done
    @item = Item.find(params[:id])
    @item.status_done
    redirect_to items_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :user_id, :status, :expiration)
  end
end
