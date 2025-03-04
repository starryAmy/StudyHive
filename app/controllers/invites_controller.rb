class InvitesController < ApplicationController

  def create
    @invite = Invite.create(room_id: params[:room_id], user_id: params[:user_id])
  end

  private
  def invite_params
    params.require(:invite).permit(:room_id, :user_id)
  end
end
