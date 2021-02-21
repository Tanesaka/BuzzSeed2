require 'rails_helper'

describe 'Users', type: :request do
  before do
    # 登録しているuserを使うのでcreateとします。
    @user = FactoryBot.create(:user)
    # deviseのメソッドであるsign_inでログインしています。
    sign_in @user
  end

  after do
    sign_out @user
  end
  it "一覧画面へリクエストが成功する" do
    get users_path
    expect(response.status).to eq 200
  end
  it "一覧画面にuserが表示されている" do
    get users_path
    expect(response.body).to include @user.name
  end
  it "マイページへリクエストが成功する" do
    get user_path(@user)
    expect(response.status).to eq 200
  end
  it "マイページにuserのunique_codeが表示されている" do
    get user_path(@user)
    expect(response.body).to include @user.unique_code
  end
  it "マイページにuserのフォロー数が表示されている" do
    get user_path(@user)
    expect(response.body).to include "#{@user.followings.count}"
  end
  it "マイページにuserのフォロワーー数が表示されている" do
    get user_path(@user)
    expect(response.body).to include "#{@user.followers.count}"
  end
  it "マイページにuserのお題数が表示されている" do
    get user_path(@user)
    expect(response.body).to include "#{@user.themes.count}"
  end
end
