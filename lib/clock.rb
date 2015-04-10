require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

handler do |job|
	Question.delete_old_question()
end

every(3.seconds, 'job')