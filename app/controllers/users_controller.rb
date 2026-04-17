class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5).reverse_order
  end

  def show
  @user = User.find(params[:id])
  @posts = @user.posts.page(params[:page]).per(8).reverse_order
  @following_users = @user.following
  @follower_users = @user.followers

  unless @user.id == current_user.id
    @is_room = false
    @room_id = nil

    current_room_ids = current_user.entries.pluck(:room_id)
    another_room_ids = @user.entries.pluck(:room_id)

    common_room_ids = current_room_ids & another_room_ids

    if common_room_ids.present?
      @is_room = true
      @room_id = common_room_ids.first
    else
      @room = Room.new
      @entry = Entry.new
    end
  end
end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
