class Message < ApplicationRecord
  paginates_per 20
  belongs_to :user
  belongs_to :conversation
  validates_presence_of :body
end
