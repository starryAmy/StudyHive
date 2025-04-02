class DesksController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_desk_and_user, only: [:show]
  before_action :set_basic_info, only: [:show]
  PER_PAGE = 4
  def index
    # get the page params
    @page = (params[:page] || 1).to_i
    # everytime we press the button, there will be ten more new data
    search_results
    respond_to do |format|
      format.html  # loading in HTML in normal case
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        "search_results",
        partial: "desks/search_results",
        locals: { desks: @desks, all_desks: @all_desks }
      )
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
    search_results
    @has_more_pages = @all_desks.count > @page * PER_PAGE
    page = @page

    respond_to do |format|
      format.turbo_stream do
        render :load_more_results, locals: { desks: @desks, page: page, has_more_pages: @has_more_pages }  # loading in turbo stream
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

  def search_results
    query = params[:query].strip if params[:query].present?
    type = params[:search_type]
    base_scope =
      if query.present?
        case type
        when "title"
          Desk.where("title ~* ?", "\\m#{params[:query]}\\M")
        when "user"
          Desk.joins(:user).where("users.username  ~* ?", "\\m#{params[:query]}\\M")
        end
      else
        Desk.all
      end
    @desks = base_scope.limit(PER_PAGE).offset((@page - 1) * PER_PAGE) #only loading new data
    @all_desks = base_scope.all
    @desks = @desks.map do |desk|
      status = desk.user.last_online_at.present? && desk.user.last_online_at > 30.minutes.ago ? "🟢 Online" : "🔴 Offline"
      OpenStruct.new(desk: desk, status: status)
    end
  end

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
