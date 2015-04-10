class QuestionsController < ApplicationController
	def new
		@title = "Create question"
	end

  def create
		render plain: Question.create_question(params)
	end

	def show
		@question = Question.set_time_view_and_delete_old_question(params)
		# Question.delay.delete_old_question()
		@title = @question.title
		# binding.pry	
		# return false
	end
	
	def answer
		UserAnswer.create_user_answer(params)
		render plain: true
	end

	def get_statistical
		@hash_return = Question.statistical(
			Date.today.beginning_of_month.strftime("%d-%m-%Y"), 
			Time.now.strftime("%d-%m-%Y")
			)
		@title = "Statistical"
		render :template => 'questions/statistical'
	end

	def post_statistical
		@hash_return = Question.statistical(
			params[:start_date], 
			params[:end_date]
			)
		@title = "Statistical"
		render :template => 'questions/statistical'
	end
end
