class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  # Remember to create a migration!
  validates_uniqueness_of :user_id,  :scope => "survey_id"
end
