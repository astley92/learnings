class Webhook < ApplicationRecord
  validates_format_of :url, with: /(http|https).+/i
  belongs_to :user

  enum status: {
    "unknown": 0,
    "checking": 1,
    "active": 2,
    "failed": 3,
  }
end
