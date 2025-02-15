class MessagesController < ApplicationController
  def create
    @desk = Desk.find(params[:desk_id])
    @message = Message.new(message_params)
    @message.desk = @desk
    @message.user = current_user ? current_user : User.where.not(id: @desk.user_id).sample
    if @message.save
      redirect_to desks_path, notice: "Message sent successfully!"
    else
      redirect_to desks_path, alert: "Failed sending message"
    end


  end

  private

  def message_params
    params.require(:message).permit(:date, :text)
  end
end
