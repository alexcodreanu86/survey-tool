class Option < ActiveRecord::Base
  belongs_to :question

  validates :content, presence: true, uniqueness: true
  # Remember to create a migration!
end
