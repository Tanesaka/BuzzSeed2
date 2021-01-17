require 'rails_helper'

describe 'Themes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user, name: "その他ユーザー")
  end

  after do
    sign_out @user
  end

  it 'フォローー覧に名前がある' do
    FactoryBot.create(:relation, user_id: @user.id, follow_id: @other_user.id)
    get user_following_path(@user)
    expect(response.body).to include @other_user.name
  end
  it 'フォロワー一覧に名前がある' do
    FactoryBot.create(:relation, user_id: @other_user.id, follow_id: @user.id)
    get user_follower_path(@user)
    expect(response.body).to include @other_user.name
  end
end
