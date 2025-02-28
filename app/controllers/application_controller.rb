class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :update_user_last_online, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    desks_path
  end

  def after_sign_out_path_for(resource_or_scope)
    desks_path
  end

  def update_user_last_online
    current_user.update_column(:last_online_at, Time.current)
  end

  def followed_users_status

    @followed_users = User.joins(:desk)  # 先讓 User 連接到 Desk
                          .where(desks: { id: Favorite.where(favoritor: current_user).select(:favoritable_id) })
                          .distinct
                          .includes(spots: :room)

    render json: @followed_users.shuffle.first(6).map { |user|
      {
        id: user.id,
        name: user.username,
        online: user.last_online_at.present? && user.last_online_at > 30.minutes.ago,
        last_online_at: user.last_online_at,
        spots: user.spots.where(active: true).map do |spot|
          {
            room: spot.room&.title,
            room_id: spot.room&.id,
            room_status: spot.room&.public ? "Public" : "Private",
            status: spot.status,
            active: spot.active
          }
        end
      }
    }
  end
end
