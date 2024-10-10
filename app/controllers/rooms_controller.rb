class RoomsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしているか確認
  before_action :set_user

  def index
  end

  def own
    @rooms = @user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = current_user
  end

  def room_params
    params.require(:room).permit(:avatar, :name, :detail, :fee, :address, :user_id)
  end
end
