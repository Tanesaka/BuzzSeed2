# frozen_string_literal: true

require 'rails_helper'

describe 'answerモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.create(:answer)).to be_valid
  end
  it "contentが空白の場合エラーとなるか" do
    theme = FactoryBot.create(:theme)
    answer = Answer.new(content: '', theme_id: theme.id, user_id: theme.user.id)
    expect(answer).to be_invalid
  end
end
