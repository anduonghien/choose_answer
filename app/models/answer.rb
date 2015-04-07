class Answer < ActiveRecord::Base
	belongs_to :questions

	def self.abc(a)
		a
	end
end
