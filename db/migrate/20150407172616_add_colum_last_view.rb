class AddColumLastView < ActiveRecord::Migration
	def change
		change_table :questions do |t|
			t.integer :last_view
		end
	end
end
