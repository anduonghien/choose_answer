class CreateQuestions < ActiveRecord::Migration
  def up
			create_table :questions do |t|
				t.string :title
				t.string :memo
				t.integer :user_id, null: false, references: [:users, :id]
				t.string :token
				t.timestamps null: false
			end
	end
	def down
		drop_table :questions
	end
end
