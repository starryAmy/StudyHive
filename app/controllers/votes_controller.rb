class VotesController < ApplicationController
  def create
    @chatmessage = Chatmessage.find(params[:chatmessage_id])
    @chatmessage.liked_by current_user
    @chatmessage.update_cached_votes

    render json: {
    liked: true,
    likes: @chatmessage.cached_votes_up
  }
  end

  def destroy
    @chatmessage = Chatmessage.find(params[:chatmessage_id])
    @chatmessage.unliked_by current_user
    @chatmessage.update_cached_votes

    render json: {
    liked: false,
    likes: @chatmessage.cached_votes_up
  }
  end
end
