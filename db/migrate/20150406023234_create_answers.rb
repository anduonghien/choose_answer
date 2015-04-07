class CreateAnswers < ActiveRecord::Migration
  def up
			create_table :answers do |t|
				t.string :content
				t.integer :question_id, null: false, references: [:questions, :id]
				t.timestamps null: false
			end
	end
	def down
		drop_table :answers
	end
end
