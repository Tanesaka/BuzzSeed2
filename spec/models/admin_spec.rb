# frozen_string_literal: true
require 'rails_helper'

describe 'adminモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.build(:admin)).to be_valid
  end
  it "メールアドレスが空白の場合に空白のバリデーションチェックが行われるか" do
    admin = Admin.new(email: "", password: "exampass", password_confirmation: "exampass")
    expect(admin).to be_invalid
  end

end