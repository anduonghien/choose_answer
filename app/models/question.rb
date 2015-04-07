class Question < ActiveRecord::Base
	has_many :answers
	has_many :user_answers
	validates :title, presence: true
	validates_associated :answers, :user_answers

	def self.createQuestion(params)
		@answer = params[:answer].split("\n")
		@tokenQuestion = Digest::MD5.hexdigest(Time.now.to_i.to_s + Random.rand(999).to_s);
		@question = Question.create(title: params[:title], memo: params[:memo], user_id: 0, token: @tokenQuestion)

		answers = []
		@answer.each do |content_answer|
			answer = {
				content: content_answer.sub("\r",""),
				question_id: @question.id
			}
			answers << answer
		end

		Answer.create(answers)

		return @tokenQuestion
	end
end
