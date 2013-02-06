class Token < ActiveRecord::Base
  attr_accessible :access_token, :access_token_secret, :consumer_key, :consumer_secret
end
