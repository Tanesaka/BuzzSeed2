# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  it "有効なヒトコト登録内容の場合は保存されるか" do
    expect(FactoryBot.create(:answer)).to be_valid
  end
end