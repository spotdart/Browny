require 'testy'

class FrontController < ApplicationController
  include Testy
  
  def index
    @test = test
    @tweets = Tweet.find(:all, :order => "created_at DESC")[1..10]
    render :index
  end

  def swap
    text = params[:tweet_id]
    render :json => {:text => text, :image => "http://si0.twimg.com/profile_images/278748917/Nietzsche1882_normal.jpg"}.to_json
  end
  
end
