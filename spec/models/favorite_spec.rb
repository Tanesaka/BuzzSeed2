# frozen_string_literal: true

require 'rails_helper'

describe 'favoriteモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.create(:favorite)).to be_valid
  end
end
