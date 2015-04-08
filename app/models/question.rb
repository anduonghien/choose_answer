class Question < ActiveRecord::Base
	has_many :answers
	has_many :user_answers
	validates :title, presence: true
	validates_associated :answers, :user_answers
	#Create question
	def self.create_question(params)
		@answer = params[:answer].split("\n")
		@tokenQuestion = Digest::MD5.hexdigest(
			Time.now.to_i.to_s + Random.rand(999).to_s
			)
		@question = Question.create(
			last_view: Time.now.to_i, 
			title: params[:title], 
			memo: params[:memo], 
			user_id: 0, 
			token: @tokenQuestion
			)

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
	#Find question and update last_view for question
	def self.set_time_view_and_delete_old_question(params)
		@question = Question.find_by(token: params[:token])
		@question.last_view = Time.now.to_i
		@question.save
		return @question
	end
	#Delete question has last_view < 1 month ago
	def self.delete_old_question()
		# Time.now.to_i - 1.month.to_i
		questions = Question.where(
			"last_view < :time_1_month_ago", 
			{time_1_month_ago: Time.now.to_i - 1.month.to_i}
			)
		questions.each do |question|
			# question.destroy_all
			# rake jobs:workoff
			puts question.id
		end
	end

	#Statistical
	def self.statistical(start_date, end_date)
		#start_date = "15-10-2015"
		#end_date = "20-04-2015"
		#format date
		start_date = start_date[6...10] + "-" + start_date[3...5] + "-" + start_date[0...2]
		end_date = end_date[6...10] + "-" + end_date[3...5] + "-" + end_date[0...2]
		@total_questions = Question.count()
		@total_users = User.count()
		@total_answer = Answer.count()

		# create range date
		str_range_date = []
		#string_num_question_per_date
		str_num_question_per_date = ""
		str_num_users_per_date = ""
		str_num_answer_per_date = ""
		#loop array date
		(start_date..end_date).each do |day|
			str_range_date << day[8...10] + "-" + day[5...7] + "-" + day[0...4]
			str_num_question_per_date += Question.where(
				"created_at >= :start AND created_at <= :end", 
				{start: day+" 00:00:00", end: day+" 23:59:59"}
				).count().to_s + ", "
			str_num_users_per_date += User.where(
				"created_at >= :start AND created_at <= :end", 
				{start: day+" 00:00:00", end: day+" 23:59:59"}
				).count().to_s + ", "
			str_num_answer_per_date += Answer.where(
				"created_at >= :start AND created_at <= :end", 
				{start: day+" 00:00:00", end: day+" 23:59:59"}
				).count().to_s + ", "
		end
		@array_return = []
		@array_return << str_range_date
		# binding.pry
		@array_return << str_num_question_per_date[0...str_num_question_per_date.length-2]
		@array_return << str_num_users_per_date[0...str_num_users_per_date.length-2]
		@array_return << str_num_answer_per_date[0...str_num_answer_per_date.length-2]
		@array_return
	end

end
