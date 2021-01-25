class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_guest, only: [:edit]
  before_action :twitter_client, only: [:tweet]

  def check_guest
    if current_user.email == 'guest@example.com'
      redirect_to user_path(current_user), alert: 'その操作はゲストユーザーの場合、制限されています。'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
    # いいね総数の合計元の回答数と分けるために別途変数を定義
    @mypage_answers = @user.answers.page(params[:page]).reverse_order

    # ユーザー検索フォームに受け渡す変数
    @q = User.ransack(params[:q])

    # ユーザーが持つ全投稿のいいね合計
    @answers = @user.answers
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end
    @tweet = Tweet.new
  end

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

  def index
    # ユーザー検索フォームに受け渡す変数
    @q = User.ransack(params[:q])
    # 検索フォームから帰ってきた結果
    @users = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def following
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(20)
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(20)
  end

  def mytheme
    @user = User.find(params[:user_id])
    @mypage_themes = @user.themes.page(params[:page]).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :unique_code)
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
