class PollsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @poll = Poll.new(poll_params)
    @poll.user_id = current_user.id
    @poll.room_id = @room.id

    if @poll.save
      params[:poll][:options].each do |option|
        @poll.poll_options.create(option_text:option) unless option.blank?
      end
      redirect_to room_path(@room), notice: "A poll is created!"
    else
      render "rooms/show", alert: "Failed to create poll"
    end

  end

  private
  def poll_params
    params.require(:poll).permit(:question, :deadline)
  end
end
