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
    max_likes = @room.chatmessages.order(cached_votes_up: :desc).limit(1).pluck(:cached_votes_up).first
    @chatmessages_most_liked = Chatmessage.where(cached_votes_up: max_likes)
    @poll = Poll.new
    @all_polls = Poll.all


    @spot_current_user = Spot.find_by(user: current_user, room: @room)
    @spot_current_user.update(active: true) if @spot_current_user.present?
    @spots_accepted = Spot.where(status: :accepted, room: @room)

    if params[:youtube_id].present?
      url = params[:youtube_id]
      video_id = url[/[?&]v=([a-zA-Z0-9_-]+)/, 1]
      time_stamp = url[/[?&](?:t|start)=([0-9]+)/, 1]
      @youtube_id = time_stamp ? params[:youtube_id][/[?&]v=([a-zA-Z0-9_-]+)/, 1] : video_id
    else
      @youtube_id = "ErPNkvLCDSQ?start=20"
    end
    # raise

    # ErPNkvLCDSQ&t=20s
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
