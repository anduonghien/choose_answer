class Question < ActiveRecord::Base
	has_many :answers
	has_many :user_answers
	validates :title, :memo,  presence: true
end
