class FollowsController < ApplicationController

  def create
    @desk = Desk.find(params[:desk_id])
    current_user.favorite(@desk)
    redirect_to desk_path(@desk), notice: "You followed this desk."
  end

  def destroy
    @desk = Desk.find(params[:desk_id])
    current_user.unfavorite(@desk)
    redirect_to @desk, notice: "You unfollowed this desk."
  end
end
