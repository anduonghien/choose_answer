class UserAnswer < ActiveRecord::Base
	# validates :user, :answer, :question_id  presence: true
	belongs_to :question
	belongs_to :user
end
