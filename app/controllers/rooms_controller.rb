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
      #@spot = Spot.new(user: current_user, room: @room, status: :accepted)
      redirect_to rooms_path, notice: "Room is built successfully!"
    else
      puts @room.errors.full_messages
      render "new", alert: "Failed sending message"
    end
  end

  def index
    @rooms = Room.all
    @desk = current_user.desk
    @is_entering_allowed = true

    if params[:query].present?
      case params[:search_type]
      when "title"
        @rooms = Room.where("title ILIKE ?", "%#{params[:query]}%").all
      when "user"
        @rooms = Room.joins(:user).where("users.username ILIKE ?", "%#{params[:query]}%").all
      end
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find(params[:id])
    @all_users = User.all.where.not(id: current_user.id)
    @spot_current_user = Spot.find_by(user: current_user, room: @room)
    @participant_type = participant_type

    if @room.public == false && (@spot_current_user.nil? || @spot_current_user.status != "accepted")
      redirect_to rooms_path, alert: "You cannot enter this private room unless your spot is accepted."
      return
    end

    @chatmessage = Chatmessage.new
    @max_likes = @room.chatmessages.order(cached_votes_up: :desc).limit(1).pluck(:cached_votes_up).first
    @chatmessages_most_liked = Chatmessage.where(cached_votes_up: @max_likes)
    @poll = Poll.new
    @all_polls = @room.polls.includes(:poll_options).sort_by { |poll| poll.user_voted?(current_user) ? 1 : 0 }
    @notifications = Notification.where(room: @room).order(created_at: :desc)

    @spot_current_user.update(active: true) if @spot_current_user.present?
    @spots_accepted = Spot.where(status: :accepted, room: @room)


    if params[:youtube_id].present?
      Notification.create(category: "youtube", user: current_user, room: @room)
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
    unless params[:idx_to_remove].present? || params[:input_field].present?
      @room.update(rooms_params)
      redirect_to room_path @room
      return
    end

    if params[:input_field].present?
      @room.res_list << params[:input_field]
    else
      @room.res_list.delete_at(params[:idx_to_remove].to_i)
    end

    if @room.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("resources-submit-form",
              partial: "shared/resources_submit_form",
              locals: { room: @room, user: "owner" }),
            turbo_stream.replace("resources-list",
              partial: "shared/resources_list",
              locals: { user: "owner", room: @room })
          ]
        end
      end
      broadcast_update
    else
      redirect_to room_path @room
    end
  end

  def my_rooms
    @rooms_member = []
    @rooms_owned = []
    @is_entering_allowed = true
    current_user.spots.each do |spot|
      room = spot.room
      room.user == current_user ? @rooms_owned << room : @rooms_member << room
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private

  def rooms_params
    params.require(:room).permit(:title, :locked, :public, :res_list)
  end

  def broadcast_update
    # @room.broadcast_replace_to("room_#{@room.id}_resources/owner",
    #                     target: "resources-list",
    #                     partial: "shared/resources_list",
    #                     locals: { user: "owner", room: @room })

    @room.broadcast_replace_to("room_#{@room.id}_resources/member",
                        target: "resources-list",
                        partial: "shared/resources_list",
                        locals: { user: "member", room: @room })
  end

  def participant_type
    (current_user == @room.user ? "owner" : "member")
  end
end
