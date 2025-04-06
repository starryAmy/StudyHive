class RoomsController < ApplicationController
  before_action :authenticate_user!
  def new
    @room = Room.new
  end

  def create
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
    raw_rooms = Room.all
    @desk = current_user.desk
    @rooms = show_all_rooms(raw_rooms)
  end

  # render all hives
  def render_search_results
    query = params[:query].strip if params[:query].present?
    type = params[:search_type]
    if query.present?
      case type
      when "title"
        raw_rooms = Room.where("title ~* ?", "\\m#{params[:query]}\\M").all
      when "user"
        raw_rooms = Room.joins(:user).where("users.username  ~* ?", "\\m#{params[:query]}\\M").all
      end
    else
        raw_rooms = Room.all
    end
    @rooms = show_all_rooms(raw_rooms)
    respond_to do |format|
      # just in case user tried to type in the url manually
      format.html { render plain: "Wrong URL" }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        "search_results",
        partial: "rooms/rooms_index_search_results",
        locals: { rooms: @rooms }
      )
      end
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

  end

  def update_youtube
    @room = Room.find(params[:room_id])
    youtube_url = params[:youtube_id]

    unless youtube_url.present?
      redirect_to @room, alert: "Please enter a YouTube link."
      return
    end

    youtube_info = extract_youtube_id(youtube_url)
    unless youtube_info
      redirect_to @room, alert: "Invalid YouTube link."
      return
    end

    if @room.update(youtube_id: youtube_info[:id], youtube_start_time: youtube_info[:time])
      Notification.create(category: "youtube", user: current_user, room: @room)
      redirect_to @room, notice: "YouTube video updated."
    else
      render :show
    end

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
    current_user.spots.each do |spot|
      room = spot.room
      room.user == current_user ? @rooms_owned << room : @rooms_member << room
    end
    @rooms_owned = show_all_rooms(@rooms_owned)
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private

  def rooms_params
    params.require(:room).permit(:title, :locked, :public, :res_list, :youtube_id)
  end

  def broadcast_update
    # broadcast to the page that has turbo_stream tag of below channel name
    @room.broadcast_replace_to("room_#{@room.id}_resources/member",
                        target: "resources-list",
                        partial: "shared/resources_list",
                        locals: { user: "member", room: @room })
  end

  def participant_type
    (current_user == @room.user ? "owner" : "member")
  end

  def show_all_rooms(rooms)
    rooms = rooms.map do |room|
      is_entering_allowed = false
      room_status_text = nil

      if (room.public == true && room.locked == false) || room.user == current_user
        is_entering_allowed = true
      elsif room.public == false && room.locked == false && Spot.exists?(room: room, user: current_user, status: :pending)
        is_entering_allowed = false
        room_status_text = "Join request has been sent."
      elsif room.public == false && room.locked == false && Spot.exists?(room: room, user: current_user, status: :accepted)
        is_entering_allowed = true
      elsif room.public == false && room.locked == false
        is_entering_allowed = false
      elsif room.locked == true
        is_entering_allowed = false
        room_status_text = "Sorry this room is locked."
      end
      OpenStruct.new(room: room, status: is_entering_allowed, status_text: room_status_text)
    end
  end

  def extract_youtube_id(url)
    return nil if url.blank?

    begin
      # Parse the URL to extract the host, path, and query parameters
      uri = URI.parse(url)
    rescue URI::InvalidURIError
      return nil
    end

    host = uri.host&.downcase
    id = nil
    time = nil

    case host
    when "youtu.be"
      # e.g. https://youtu.be/abc123XYZ?t=90
      id = uri.path[1..]
      time = CGI.parse(uri.query.to_s)["t"]&.first
    when "www.youtube.com", "youtube.com", "m.youtube.com"
      params = CGI.parse(uri.query.to_s)

      if uri.path == "/watch"
        id = params["v"]&.first
        time = params["t"]&.first || params["start"]&.first
      elsif uri.path.start_with?("/embed/")
        id = uri.path.split("/")[2]
        time = params["start"]&.first
      elsif uri.path.start_with?("/shorts/")
        id = uri.path.split("/")[2]
      end
    end

    return nil unless id

    { id: id, time: time }
  end

end
