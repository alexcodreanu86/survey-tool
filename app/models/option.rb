class Option < ActiveRecord::Base
  belongs_to :question
  # Remember to create a migration!
end
