# frozen_string_literal: true

require 'rails_helper'
describe 'ユーザー一覧画面のテスト' do
  # let(:user) { FactoryBot.create(:user) }
  before do
    @user = create(:user)
    sign_in @user
    visit users_path
  end

  after do
    # サインアウト
    sign_out @user
  end

  it "users_pathが/usersか" do
    expect(current_path).to eq('/users')
  end
  it "userが表示されているか、ニックネームにリンク適用されているか" do
    expect(page).to have_content user.name
    expect(page).to have_link user.name
  end
end
