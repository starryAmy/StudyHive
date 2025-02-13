class SpotsController < ApplicationController
<<<<<<< HEAD
  def index
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
=======
  def update
    @spot = Spot.find(params[:id])
    @spot.status = params[:status]
    @spot.save
>>>>>>> master
  end
end
