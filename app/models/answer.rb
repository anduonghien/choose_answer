class Answer < ActiveRecord::Base
	# validates :question_id, :content,  presence: true
	belongs_to :questions
end
