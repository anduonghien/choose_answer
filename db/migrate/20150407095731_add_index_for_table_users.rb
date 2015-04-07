class AddIndexForTableUsers < ActiveRecord::Migration
  def change
  	add_index(:users, :id)
  	add_index(:questions, :token)
  	add_index(:answers, :id)
  	add_index(:user_answers, :id)
  end
end
