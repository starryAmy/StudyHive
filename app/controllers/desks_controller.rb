class DesksController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_desk_and_user, only: [:show]
  before_action :set_basic_info, only: [:show]

  def index
    # get the page params
    @page = (params[:page] || 1).to_i
    # everytime we press the button, there will be ten more new data
    per_page = 4
    if params[:query].present?
      case params[:search_type]
      when "title"
        @desks = Desk.where("title ILIKE ?", "%#{params[:query]}%").limit(per_page).offset((@page - 1) * per_page) #only loading new data
        @all_desks = Desk.joins(:user).where("title ILIKE ?", "%#{params[:query]}%").all
      when "user"
        @desks = Desk.joins(:user).where("users.username ILIKE ?", "%#{params[:query]}%").limit(per_page).offset((@page - 1) * per_page) #only loading new data
        @all_desks = Desk.joins(:user).where("users.username ILIKE ?", "%#{params[:query]}%").all
      end
    else
      @desks = Desk.limit(per_page).offset((@page - 1) * per_page) #only loading new data
      @all_desks = Desk.all
    end

    respond_to do |format|
      format.html  # loading in HTML in normal case
      # the reason why we added as: :ask was becuase ruby will auto render elements with variable name of card
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("search_results", partial: "desks/search_results", locals: { all_desks: @all_desks, desks: @desks, online_status: @online_status })  # loading in turbo stream
      end
    end
  end
  def show
    @message = Message.new

    if params.keys.count > 3
      @query =  params["desk"]["question"]
      openai_service = OpenaiService.new
      @response = openai_service.generate_response(@query)
    end

  end

  def load_more
    @page = params[:page].to_i
    per_page = 4
    if params[:query].present?
      case params[:search_type]
      when "title"
        @desks = Desk.where("title ILIKE ?", "%#{params[:query]}%").limit(per_page).offset((@page - 1) * per_page) #only loading new data
        @all_desks = Desk.joins(:user).where("title ILIKE ?", "%#{params[:query]}%").all
      when "user"
        @desks = Desk.joins(:user).where("users.username ILIKE ?", "%#{params[:query]}%").limit(per_page).offset((@page - 1) * per_page) #only loading new data
        @all_desks = Desk.joins(:user).where("users.username ILIKE ?", "%#{params[:query]}%").all
      end
    else
      @desks = Desk.limit(per_page).offset((@page - 1) * per_page) #only loading new data
      @all_desks = Desk.all
    end
    @has_more_pages = @all_desks.count > @page * per_page
    page = @page
    puts "💥 format: #{request.format}"
    respond_to do |format|
      format.turbo_stream do
        render :load_more_results, locals: { desks: @desks, page: page, has_more_pages: @has_more_pages, online_status: @online_status }  # loading in turbo stream
      end
      format.html { render plain: "HTML fallback triggered" }
    end
  end
  def update
    @desk = Desk.find(params[:id])
    @desk.update(desk_params)
    redirect_to desk_path(@desk)
  end

  private

  def set_desk_and_user
    if Desk.exists?(id: params[:id])
      @desk = Desk.find(params[:id])
      @user = @desk.user
    else
      @desk = current_user.desk
      @user = current_user
    end
  end

  def set_basic_info
    @online_status = @desk.user.last_online_at.present? && @desk.user.last_online_at > 30.minutes.ago
    @active_spot = @desk.user.spots.includes(:room).where(active: true).first
    @if_in_room = @active_spot.present?

    if @active_spot
      @room_status = @active_spot.room&.public ? "Public" : "Private"
      @room_title = @active_spot.room&.title
    else
      @room_status = nil
      @room_title = nil
    end
  end

  def desk_params
    params.require(:desk).permit(:title, :intro, :interest, :question)
  end
end
