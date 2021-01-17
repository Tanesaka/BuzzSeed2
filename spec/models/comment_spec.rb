# frozen_string_literal: true

require 'rails_helper'

describe 'commentモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.create(:comment)).to be_valid
  end
  it "contentが空白の場合エラーとなるか" do
    answer = FactoryBot.create(:answer)
    comment = Comment.new(content: '', answer_id: answer.id, user_id: answer.user.id)
    expect(comment).to be_invalid
  end
end
