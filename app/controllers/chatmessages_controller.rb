class ChatmessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_current_user
  def create
    @room = Room.find(params[:room_id])
    @chatmessage = Chatmessage.new(chatmessage_params)
    @chatmessage.room = @room
    @chatmessage.user = current_user

    if @chatmessage.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:chatmessages, partial: "chatmessages/chatmessage", locals: { chatmessage: @chatmessage, liked: false })
        end
        format.html { redirect_to room_path(@room) }
      end
    else
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private
  def set_current_user
    @current_user = current_user
  end
  def chatmessage_params
    params.require(:chatmessage).permit(:content)
  end
end
