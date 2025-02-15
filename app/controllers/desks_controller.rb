class DesksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    # @desk = current_user.desk
    if params[:id].nil?
      @desk = current_user.desk
    else
      @desk = Desk.find(params[:id])
    end
      @user = User.find(@desk.user_id)
    # get the page params
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    # everytime we press the button, there will be ten more new data
    per_page = 2
    @desks = Desk.limit(per_page).offset((@page - 1) * per_page) #only loading new data
    @all_desks = Desk.all

    respond_to do |format|
      format.html  # loading in HTML in normal case
      # the reason why we added as: :ask was becuase ruby will auto render elements with variable name of card
      format.js {render partial: "shared/card", collection: @desks, as: :desk, layout: false, formats: [:html]} # when there is AJAX request, respond js
    end
  end
  def show
    if params[:id].nil?
      @desk = current_user.desk
    else
      @desk = Desk.find(params[:id])
    end
      @user = User.find(@desk.user_id)
    @message = @desk.messages.new
    # raise
  end
end
