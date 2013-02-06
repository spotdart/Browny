class TwitterClient
  attr_accessor :client, :user

  def initialize user = 'spotdart'
    @user = user
    @client = Twitter.configure do |config|
      token = Token.where("user = ?", @user).first
      raise "no credentials for #{@user}" if token.nil?
      config.consumer_key = token.consumer_key
      config.consumer_secret = token.consumer_secret
      config.oauth_token = token.access_token
      config.oauth_token_secret = token.access_token_secret
    end
  end
  
  def method_missing meth, *args, &block
    @client.send meth, *args, &block
  end

 def get_tweets
    begin
      @tweets = @client.home_timeline
    rescue Twitter::Error::ClientError
      @tweets = @client.home_timeline
    end
  end

  def store_tweets
    self.get_tweets
    @tweets.each do |tweet|
      if Tweet.where("tweet_id = ?", tweet.id).empty?
        t = Tweet.new
        t.text = tweet.text
        t.user = @user
        t.tweet_id = tweet.id
        t.profile_image_url = tweet.user.profile_image_url
        t.save
      end
    end
  end

  def print_tweets
    self.get_tweets
    @tweets.each do |tweet|
      puts tweet.text
    end
  end

end
