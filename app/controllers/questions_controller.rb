class QuestionsController < ApplicationController

	def new
		@title = "Create question"
	end

	def create
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

		render plain: @tokenQuestion
	end

	def show
		@question = Question.find_by(token: params[:token])
		@title = @question.title
		# binding.pry	
		# return false
	end

	def answer
		@user = User.create(full_name: params[:full_name], token: Digest::MD5.hexdigest(Time.now.to_i.to_s + Random.rand(999).to_s));
		@user_answer = UserAnswer.create(user_id: @user.id, question_id: params[:question_id], answer: params[:answer], note: params[:note]);
		render plain: true
	end
end
