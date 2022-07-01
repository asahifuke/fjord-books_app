class CreateUserFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :user_follows do |t|
      t.integer :follower_id, index: true
      t.integer :followed_id, index: true

      t.timestamps
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
