# frozen_string_literal: true

require 'rails_helper'

describe 'notificationモデルのテスト' do
  before do
    @visitor = FactoryBot.create(:user)
    @visited = FactoryBot.create(:user)
    @answer = FactoryBot.create(:answer, user_id: @visited.id)
    @comment = FactoryBot.create(:comment, user_id: @visitor.id, answer_id: @answer.id)
  end

  it "有効な登録内容の場合は保存されるか(フォロー時)" do
    notification = Notification.create(visitor_id: @visitor.id, visited_id: @visited.id)
    expect(notification).to be_valid
  end
  it "有効な登録内容の場合は保存されるか(コメント時)" do
    notification = Notification.create(visitor_id: @visitor.id, visited_id: @visited.id, answer_id: @answer.id, comment_id: @comment.id)
    expect(notification).to be_valid
  end
  it "visitorとNotification 1:N" do
    Notification.create(visitor_id: @visitor.id, visited_id: @visited.id)
    expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
  end
end
