class ItemsController < ApplicationController
  def index
    @open_items = current_user.items.where("expiration > ? AND status = ?", DateTime.now, "open")
    @expired_items = current_user.items.where("expiration <= ? AND status = ?", DateTime.now, "open")
    @completed_items = current_user.items.where(status: "done")

  end

  def new
    @item=Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def destroy
    @user = current_user
    @item = Item.find(params[:id])

    @open_items = current_user.items.where("expiration > ? AND status = ?", DateTime.now, "open")
    @expired_items = current_user.items.where("expiration <= ? AND status = ?", DateTime.now, "open")
    @completed_items = current_user.items.where(status: "done")

    if @item.destroy
      flash[:notice] = " To Do Item Successfully Deleted."
      # redirect_to items_path(@wiki)
    else
      flash[:error] = "There Was An Error Deleting Your To Do Item.  Please Try Again."
      # render :show
    end

    respond_to do |format|
      format.html
      format.js
    end
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

  def redo
    @item = Item.find(params[:id])
    @item.make_to_open
    redirect_to items_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :user_id, :status, :expiration)
  end
end
