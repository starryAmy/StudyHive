class DesksController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_desk_and_user, only: [:show]

  def index
    # get the page params
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    # everytime we press the button, there will be ten more new data
    per_page = 4
    if params[:query].present?
      case params[:search_type]
      when "title"
        @desks = Desk.where("title ILIKE ?", "%#{params[:query]}%").limit(per_page).offset((@page - 1) * per_page) #only loading new data
        @all_desks = Desk.where("title ILIKE ?", "%#{params[:query]}%").all
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
      format.js {render partial: "shared/card", collection: @desks, as: :desk, layout: false, formats: [:html]} # when there is AJAX request, respond js
    end
  end
  def show
    @message = Message.new
    # raise
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
end
