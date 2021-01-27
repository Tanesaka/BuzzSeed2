class Sns::DataTweet

  def self.data_tweet
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['api_key']
      config.consumer_secret = ENV['api_secret_key']
      config.access_token = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
    @answers = Answer.all
    @favorites = Favorite.all
    @themes = Theme.all
    @client.update!("BuzzSeed総合データをツイートします。\r
      総お題数：" + @themes.count.to_s + "\r
      総ヒトコト数：" + @answers.count.to_s + "\r
      総Good!数：" + @favorites.count.to_s + "
      \r早速アクセス!!\rbuzzseed.info/\r
      #BuzzSeed")
  end

end