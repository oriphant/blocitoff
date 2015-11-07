class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def show
    @user = current_user
    @items = @user.items
    # @items = Item.find(params[:id])
    # http://stackoverflow.com/questions/15693479/couldnt-find-user-with-id-activerecordrecordnotfound
    # http://stackoverflow.com/questions/30858104/couldnt-find-user-with-id-show
  end
end

private
def user_params
  params.require(:user).permit(:name)
end