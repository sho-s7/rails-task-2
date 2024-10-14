class RoomsController < ApplicationController
  before_action :authenticate_user!
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
      flash[:primary] = "施設が作成されました"
      redirect_to room_path(@room.id)
    else
      flash.now[:danger] = "施設の作成に失敗しました"
      render :new
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
      flash[:primary] = "施設情報が更新されました"
      redirect_to room_path
    else
      flash.now[:danger] = "施設情報の更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:primary] = "施設が削除されました"
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
