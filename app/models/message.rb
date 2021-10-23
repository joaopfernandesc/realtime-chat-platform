class Message < ApplicationRecord
  validates(:sender, :body, :room, presence: true)
end
