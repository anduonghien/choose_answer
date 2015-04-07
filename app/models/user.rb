class User < ActiveRecord::Base
	has_many :user_answers
	# validates :question_id, presence: true
end
