class PollOption < ApplicationRecord
  acts_as_votable
  belongs_to :poll
end
