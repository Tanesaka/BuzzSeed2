# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  # 下記でアソシエーションは自動的に組まれる
  let(:user) { FactoryBot.create(:user) }
  let(:theme) { FactoryBot.create(:theme, user_id: user.id) }
  let(:answer) { FactoryBot.build(:answer, user_id: user.id, theme_id: theme.id) }
  it "有効なヒトコト登録内容の場合は保存されるか" do
    expect(answer).to be_valid
  end
end