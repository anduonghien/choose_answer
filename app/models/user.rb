class User < ActiveRecord::Base
	has_many :user_answers
	validates_associated :user_answers

	scope :get_num_on_day, ->(day) { 
		where("created_at >= ? AND created_at <= ?", day.beginning_of_day, day.end_of_day)
	}
end
