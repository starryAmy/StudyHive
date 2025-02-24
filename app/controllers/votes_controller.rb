class VotesController < ApplicationController
  def create
    @chatmessage = Chatmessage.find(params[:chatmessage_id])
    if current_user.voted_up_on? @chatmessage
      @chatmessage.unliked_by current_user
    else
      @chatmessage.liked_by current_user
    end
    @chatmessage.update_cached_votes

    render json: {
    liked: current_user.voted_for?(@chatmessage),
    likes: @chatmessage.cached_votes_up
  }
  end
end
