require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    # 登録しているuserを使うのでcreateとします。
    @user = FactoryBot.create(:user)
    # deviseのメソッドであるsign_inでログインしています。
    sign_in @user
  end
  describe 'ユーザー一覧画面のテスト' do
   it "userが表示されているか、ニックネームにリンク適用されている" do
      get users_path
      expect(response.body).to include @user.name
   end
  end
end