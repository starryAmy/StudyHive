class Poll < ApplicationRecord
  has_many :poll_options, dependent: :destroy
  has_many :ballots, dependent: :destroy
  belongs_to :user
  belongs_to :room

  def user_voted?(user)
    ballots.exists?(user_id: user.id)
  end
  def total_votes
    poll_options.sum { |option| option.votes_for.size }
  end
end
