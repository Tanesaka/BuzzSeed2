# frozen_string_literal: true
require 'rails_helper'

describe 'themeモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    # FactoryBotの記載と合わせてアソシエーションが組まれる。user_idも自動で入る
    expect(FactoryBot.create(:theme)).to be_valid
  end
  it "お題の画像が入っていない場合、エラーとなるか" do
    user = FactoryBot.create(:user)
    theme = Theme.new(image: '', user_id: user.id)
    expect(theme).to be_invalid
  end
end