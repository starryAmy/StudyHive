class SpotsController < ApplicationController
  def index
    raise
    @room = Room.find(params[:room_id])
  end

  def create
    puts params.inspect
    @room = Room.find(params[:room_id])
    @spot = Spot.new(user_id: current_user.id, room_id: @room.id, status: "pending")
    if @spot.save
      puts "send the permission!"
      redirect_to rooms_path, notice: "sent the permission!"
    else
      puts @spot.errors.full_messages
    end
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    redirect_to request.referer
  end

  private

  def spot_params
    params.require(:spot).permit(:status, :active)
  end
end
