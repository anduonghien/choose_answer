class User < ActiveRecord::Base
	# validates :question_id, presence: true
	has_many :user_answers
end
