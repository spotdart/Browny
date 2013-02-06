class AddIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweet_id, :integer
  end
end
