class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses

  validates :prompt, presence: true
end
