class User < ActiveRecord::Base
	has_many :user_answers
	validates_associated :user_answers
end
