class RoomsController < ApplicationController
  before_action :authenticate_user!
  def new
    @room = Room.new
  end

  def create
    puts "Current User: #{current_user.inspect}"

    @room = Room.new(rooms_params)
    @room.user_id = current_user.id

    if @room.save
      redirect_to rooms_path, notice: "Room is built successfully!"
    else
      puts @room.errors.full_messages
      render "new", alert: "Failed sending message"
    end
  end

  def index
    @rooms = Room.all
    @desk = current_user.desk
  end

  def show
    @room = Room.find(params[:id])
    @chatmessage = Chatmessage.new
    # @youtube_id = 101
    @youtube_id = params[:youtube_id]
    puts params.inspect
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @room.update(rooms_params)
    redirect_to request.referer
  end


  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private

  def rooms_params
    params.require(:room).permit(:title, :locked, :public)
  end

end
