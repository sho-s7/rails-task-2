class ReservationsController < ApplicationController
  before_action :set_user
  before_action :set_room, only: [:create]

  def index
    @reservations = @user.reservations
  end

  def new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to room_path(@room.id)
    else
      render "rooms/show"
    end
  end

  def show
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = "再予約しました"
      redirect_to reservations_path
    else
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to reservations_path
  end

  private

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number, :room_id, :user_id)
  end
end
