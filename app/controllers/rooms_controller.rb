class RoomsController < ApplicationController
     before_action :authenticate_user!

  def create
   @room = Room.create

   @room.entries.create(user_id: current_user.id)
   @room.entries.create(user_id: params[:room][:user_id])

   redirect_to user_room_path(current_user, @room)
  end

  def index
    my_room_id = current_user.entries.pluck(:room_id)
    @another_entries = Entry
                       .where(room_id: my_room_id)
                       .where.not(user_id: current_user.id)
                       .preload(room: :messages).preload(user: { icon_attachment: :blob })
  end

  def show
    @room = Room.find(params[:id])
    if @room.entries.where(user_id: current_user.id).present?
      @messages = @room.messages.all
      @message = @room.messages.build
      @entries = @room.entries
      @another_entry = @entries.where.not(user_id: current_user.id).first
      @user = @another_entry.user
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
