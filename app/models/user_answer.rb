class UserAnswer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	def self.createUserAnswer(params)
		@user = User.create(
			full_name: params[:full_name],
			token: Digest::MD5.hexdigest(Time.now.to_i.to_s + Random.rand(999).to_s)
		)
		UserAnswer.create(
			user_id: @user.id, 
			question_id: params[:question_id], 
			answer: params[:answer], note: params[:note]
		)
	end
end
