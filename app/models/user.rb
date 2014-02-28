class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :password, presence: true

  has_many :surveys
  has_many :participations
  has_many :taken_surveys, through: :participations, source: :survey

  # User needs to find out home many users took their surveys

  def all_surveys_user_count
  	count = 0
    self.surveys.each do |survey|
      count += survey.users.count
    end
    count
  end
end



