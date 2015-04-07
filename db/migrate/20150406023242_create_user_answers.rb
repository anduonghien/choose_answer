class CreateUserAnswers < ActiveRecord::Migration
	def up
			# 1 - user_id: 1 - question: 2 - answer: (answer_type-answer_id,) 1-0,2-1, note, timestams
    	# answer_type: 0: agree, 1:can attend, 2: not agree
    	create_table :user_answers do |t|
    		t.integer :user_id, null: false, references: [:users, :id]
    		t.integer :question_id, null: false, references: [:questions, :id]
    		t.string :answer, null: false
    		t.string :note
    		t.timestamps null: false
    	end
  end
  def down
  	drop_table :user_answers
  end
end
