class AddProfileImageToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :profile_image, :blob
  end
end
