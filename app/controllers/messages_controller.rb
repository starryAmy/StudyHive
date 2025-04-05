class MessagesController < ApplicationController
  def create
    @desk = Desk.find(params[:desk_id])
    @message = Message.new(message_params)
    @message.desk = @desk
    @message.user = current_user ? current_user : User.where.not(id: @desk.user_id).sample
    if @message.save

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:"messages-div", partial: "desks/desk_message",
            locals: { message: @message })
        end
        format.html { redirect_to booking_path(@booking) }
      end
    else
      redirect_to desk_path(@desk), alert: "Failed sending message"
    end


  end

  private

  def message_params
    params.require(:message).permit(:date, :text)
  end
end
