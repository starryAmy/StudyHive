class SpotsController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
  end

  def create

    # puts params.inspect
    @spot = Spot.new(spot_params)
    if @spot.save
      puts "send the permission!"
      redirect_to(params[:redirect] || rooms_path, notice: "Sent the permission!")
    else
      puts @spot.errors.full_messages
    end
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)

    redirect_to room_path(@spot.room)
  end

  def destroy
    #raise
    @spot = Spot.find(params[:id])
    if @spot.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to(params[:redirect])
    else
      flash[:error] = 'Something went wrong'
      redirect_to(params[:redirect])
    end
  end


  private

  def spot_params
    params.require(:spot).permit(:status, :active, :room_id, :user_id)
  end
end
