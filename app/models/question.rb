class Question < ActiveRecord::Base
	has_many :answers
	has_many :user_answers
	validates :title, presence: true
	validates_associated :answers, :user_answers

	scope :get_num_on_day, ->(day) { 
		where("created_at >= ? AND created_at <= ?", day.beginning_of_day, day.end_of_day)
	}

	#Create question
	def self.create_question(params)
		@answer = params[:answer].split("\n")
		@tokenQuestion = Digest::MD5.hexdigest("#{Time.now.to_i.to_s} #{Random.rand(999).to_s}")
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
		# questions = Question.where(
		# 	"last_view < :time_1_month_ago", 
		# 	{time_1_month_ago: Time.now.to_i - 1.month.to_i}
		# 	)
		# questions.each do |question|
		# 	# question.destroy_all
		# 	# rake jobs:workoff
		# 	puts question.id
		# end
		puts "--------------------------------"
		puts "Hehe"
		puts "--------------------------------"
	end


	def self.statistical(start_date, end_date)
		#start_date = "15-10-2015"
		#end_date = "20-04-2015"
		#conver string params to DateTime
		date_time_start_day = start_date.to_datetime
		date_time_end_day = end_date.to_datetime

		total_questions = Question.select(:id).count()
		total_users = User.select(:id).count()
		total_answer = Answer.select(:id).count()

		#string_num_question_per_date
		arr_range_date = []
		str_num_question_per_date = ""
		str_num_users_per_date = ""
		str_num_answer_per_date = ""
		#loop array date
		(date_time_start_day..date_time_end_day).each do |day|
			arr_range_date << "#{day.strftime("%d-%m-%Y")}, "
			str_num_question_per_date = "#{str_num_question_per_date}#{Question.get_num_on_day(day).select(:id).count().to_s}, "
			str_num_users_per_date = "#{str_num_users_per_date}#{User.get_num_on_day(day).select(:id).count().to_s}, "
			str_num_answer_per_date = "#{str_num_answer_per_date}#{Answer.get_num_on_day(day).select(:id).count().to_s}, "
		end
		hash_return = {
			range_day: arr_range_date,
			str_num_question: str_num_question_per_date,
			str_num_user: str_num_users_per_date,
			str_num_answer: str_num_answer_per_date,
			total_user: total_users,
			total_answer: total_answer,
			total_question: total_questions
		}
		hash_return
	end
		##bad code
	#Statistical
	# def self.statistical_bad(start_date, end_date)
	# 	#start_date = "15-10-2015"
	# 	#end_date = "20-04-2015"
	# 	#format date to 2015-10-15
	# 	start_date = "#{start_date[6...10]}-#{start_date[3...5]}-#{start_date[0...2]}"
	# 	# start_date = start_date[6...10] + "-" + start_date[3...5] + "-" + start_date[0...2]
	# 	# end_date = end_date[6...10] + "-" + end_date[3...5] + "-" + end_date[0...2]
	# 	end_date = "#{end_date[6...10]}-#{end_date[3...5]}-#{end_date[0...2]}" 
	# 	@total_questions = Question.select(:id).count()
	# 	@total_users = User.select(:id).count()
	# 	@total_answer = Answer.select(:id).count()

	# 	# create range date
	# 	str_range_date = []
	# 	#string_num_question_per_date
	# 	str_num_question_per_date = ""
	# 	str_num_users_per_date = ""
	# 	str_num_answer_per_date = ""
	# 	#loop array date
	# 	(start_date..end_date).each do |day|
	# 		str_range_date << day[8...10] + "-" + day[5...7] + "-" + day[0...4]
	# 		str_num_question_per_date += Question.get_num_on_day(day).select(:id).count().to_s + ", "
	# 		str_num_users_per_date += User.where(
	# 			"created_at >= :start AND created_at <= :end", 
	# 			{start: day+" 00:00:00", end: day+" 23:59:59"}
	# 			).count().to_s + ", "
	# 		str_num_answer_per_date += Answer.where(
	# 			"created_at >= :start AND created_at <= :end", 
	# 			{start: day+" 00:00:00", end: day+" 23:59:59"}
	# 			).count().to_s + ", "
	# 	end
	# 	@array_return = []
	# 	@array_return << str_range_date
	# 	# binding.pry
	# 	@array_return << str_num_question_per_date[0...str_num_question_per_date.length-2]
	# 	@array_return << str_num_users_per_date[0...str_num_users_per_date.length-2]
	# 	@array_return << str_num_answer_per_date[0...str_num_answer_per_date.length-2]

	# 	@array_return << @total_questions
	# 	@array_return << @total_users
	# 	@array_return << @total_answer
	# 	@array_return
	# end
end
