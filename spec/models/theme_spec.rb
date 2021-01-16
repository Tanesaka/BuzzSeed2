# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  # 下記でアソシエーションは自動的に組まれる
  let(:user) { FactoryBot.create(:user) }
  let(:theme) { FactoryBot.build(:theme, user_id: user.id) }
  it "有効なお題登録内容の場合は保存されるか" do
    expect(theme).to be_valid
  end
end