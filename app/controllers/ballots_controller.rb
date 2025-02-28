class BallotsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_current_user
  def create
    @ballot = Ballot.new
    @ballot.user_id = @current_user.id
    @ballot.poll_id = params[:poll_id]
    @poll = Poll.find(params[:poll_id])
    @room = Room.find(@poll.room_id)
    @choices = params["ballot"]["poll_option_ids"]
    @choices.each do |choice|
      @chosen_ballot = PollOption.find(choice)
      @chosen_ballot.liked_by @current_user
    end
    if @ballot.save
      Notification.create(category: "ballot", user: @current_user, room: @poll.room)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("poll_#{@poll.id}", partial: "rooms/poll", locals: { poll: @poll }),
            turbo_stream.replace("hiveboard_#{@room.id}", partial: "shared/hiveboard", locals: { notifications: Notification.where(room: @poll.room) }) ]
        end
        format.html { redirect_to room_path(@poll.room), notice: "Success!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("poll_#{@poll.id}", partial: "rooms/poll", locals: { poll: @poll })
        end
        format.html { redirect_to room_path(@poll.room), alert: "Fail!" }
      end
    end

  end


  private
  def set_current_user
    @current_user = current_user
  end
end
