class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :following_id
      t.boolean :follow
      t.timestamps
    end
  end
end
