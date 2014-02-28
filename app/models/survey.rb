class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :participants
  has_many :users, through: :participants


end
