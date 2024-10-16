class ReservationsController < ApplicationController
  before_action :set_user

  def index
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
      redirect_to room_path(@room)
    else
      @reservations = @user.reservations
    end
  end

  def new
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    if params[:back]
      render "new"
    elsif @reservation.save
      flash[:primary] = "施設の予約が完了しました"
      redirect_to reservations_path
    else
      flash.now[:danger] = "施設の予約に失敗しました"
      render "rooms/show"
    end
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)

    if @reservation.invalid?
      render "rooms/show"
    end
  end

  def edit_confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.find(params[:id])
    @reservation.attributes = reservation_params

    if @reservation.invalid?
      render "edit"
    end
  end

  def show
    redirect_to edit_reservation_path(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:primary] = "再予約しました"
      redirect_to reservations_path
    else
      flash.now[:danger] = "再予約に失敗しました"
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:primary] = "予約を削除しました"
    redirect_to reservations_path
  end

  private

  def set_user
    @user = current_user
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number, :room_id, :user_id)
  end
end
