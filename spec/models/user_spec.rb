# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  it "有効なユーザー情報登録内容の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end