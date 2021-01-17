# frozen_string_literal: true
require 'rails_helper'

describe 'userモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "unique_codeが空白の場合に空白のバリデーションチェックが行われるか" do
    user = User.new(name: "exampletaro", email: "example@exam.com", unique_code: "", password: "exampass", password_confirmation: "exampass")
    expect(user).to be_invalid
  end
end