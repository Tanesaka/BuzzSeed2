# frozen_string_literal: true
require 'rails_helper'

describe 'relationモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    # 下記のままでRelation id: 1, user_id: 1, follow_id: 2,となる(invalidにして確認済)
    expect(FactoryBot.create(:relation)).to be_valid
  end
end