class QuestionsController < ApplicationController

	def new
		@title = "Create question"
	end

	def create
		render plain: Question.createQuestion(params)
	end

	def show
		@question = Question.find_by(token: params[:token])
		@title = @question.title
		# binding.pry	
		# return false
	end

	def answer
		UserAnswer.createUserAnswer(params)
		render plain: true
	end
end
