class RoomsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしているか確認
  before_action :set_user

  def index
    if params[:address].present? && params[:keyword].present?
      @rooms = Room.where("address LIKE ? AND (name LIKE ? OR detail LIKE ?)", "%#{params[:address]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}")
    elsif params[:address].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:address]}%")
    elsif params[:keyword].present?
      @rooms = Room.where("name LIKE ? OR detail LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}")
    else
      @rooms = Room.all
    end
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
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報が更新されました"
      redirect_to room_path
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設が削除されました"
    redirect_to rooms_own_path
  end

  private

  def set_user
    @user = current_user
  end

  def room_params
    params.require(:room).permit(:avatar, :name, :detail, :fee, :address, :user_id)
  end
end
