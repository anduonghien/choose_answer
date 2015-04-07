class Answer < ActiveRecord::Base
	belongs_to :questions
	# validates :question, :content,  presence: true
end
