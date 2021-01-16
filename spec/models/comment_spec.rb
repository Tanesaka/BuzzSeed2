# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  # 下記でアソシエーションは自動的に組まれる
  let(:user) { FactoryBot.create(:user) }
  let(:theme) { FactoryBot.create(:theme, user_id: user.id) }
  let(:answer) { FactoryBot.create(:answer, user_id: user.id, theme_id: theme.id) }
  let(:comment) { FactoryBot.build(:comment, user_id: user.id, answer_id: answer.id) }
  it "有効なヒトコト登録内容の場合は保存されるか" do
    expect(comment).to be_valid
  end
  it "コメント文が空白の場合に空白のバリデーションチェックが行われるか" do
    comment = Comment.new(content: "", user_id: user.id, answer_id: answer.id)
    expect(comment).to be_invalid
  end
end