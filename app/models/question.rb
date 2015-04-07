class Question < ActiveRecord::Base
	# validates :title, :memo,  presence: true
	has_many :answers
	has_many :user_answers
end
