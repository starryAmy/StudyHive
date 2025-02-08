class DesksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @desks = Desk.all
  end
  def show
    @desk = Desk.find(params[:id])
    @user = User.find(@desk.user_id)
  end
end
