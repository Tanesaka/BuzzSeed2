class Public::TweetsController < ApplicationController
  before_action :twitter_client, only: [:tweet]

  def tweet
    @user = current_user
    @answers = @user.answers
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end
    @tweet = @user.tweets.new(tweet_params)
    if @tweet.save
      @client.update!(@user.name + "はBuzzSeedを利用しています。\r
      総ヒトコト数：" + @answers.count.to_s + "\r
      総獲得Good!数：" + @favorites_count.to_s + "
      \r" + @user.name + "のヒトコトを見る\r
      buzzseed.info/users/" + @user.id.to_s + "
      \r" + @tweet.content + "\r#BuzzSeed")
      redirect_to user_path(current_user), notice: 'tweetが完了しました！'
    else
      redirect_to user_path(current_user), alert: 'tweetできませんでした…（追加コメントは60字までです。）'
    end
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['api_key']
      config.consumer_secret = ENV['api_secret_key']
      config.access_token = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
