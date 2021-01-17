# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  it "有効なお題登録内容の場合は保存されるか" do
    # FactoryBotの記載と合わせてアソシエーションが組まれる。user_idも自動で入る
    expect(FactoryBot.create(:theme)).to be_valid
  end
end