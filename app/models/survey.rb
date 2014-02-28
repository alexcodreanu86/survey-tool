class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :participations
  has_many :users, through: :participations

  def response_users
  	users = []
    self.questions.each do |question|
      users << question.responses.user_id
    end
    
  end

end
