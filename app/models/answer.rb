class Answer < ActiveRecord::Base
	belongs_to :questions

	scope :get_num_on_day, ->(day) { 
		where("created_at >= ? AND created_at <= ?", day.beginning_of_day, day.end_of_day)
	}
end
