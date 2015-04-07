class CreateUsers < ActiveRecord::Migration
	def up
		create_table :users do |t|
			t.string :full_name
			t.string :token
			t.timestamps null: false
		end
	end
	def down
		drop_table :users
	end
end
