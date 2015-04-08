class QuestionsController < ApplicationController
	def new
		@title = "Create question"
	end

	def create
		render plain: Question.createQuestion(params)
	end

	def show
		@question = Question.setTimeViewAndDeleteOldQuestion(params)
		Question.delay.deleteOldQuestion()
		@title = @question.title
		# binding.pry	
		# return false
	end
	
	def answer
		UserAnswer.createUserAnswer(params)
		render plain: true
	end

	def getStatistical
		@array_return = Question.statistical(Date.today.beginning_of_month.strftime("%d-%m-%Y"), Time.now.strftime("%d-%m-%Y"))
		@title = "Statistical"
		render :template => 'questions/statistical'
	end

	def postStatistical
		@array_return = Question.statistical(params[:start_date], params[:end_date])
		@title = "Statistical"
		render :template => 'questions/statistical'
	end
end
