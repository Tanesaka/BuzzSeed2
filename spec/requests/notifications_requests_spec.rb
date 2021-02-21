require 'rails_helper'

describe 'Notifications', type: :request do
  before do
    # @user = FactoryBot.create(:user)
    # sign_in @user
    @visitor = FactoryBot.create(:user)
    @visited = FactoryBot.create(:user)
    @answer = FactoryBot.create(:answer, user_id: @visited.id)
    @comment = FactoryBot.create(:comment, user_id: @visitor.id, answer_id: @answer.id)
    sign_in @visited
  end

  after do
    sign_out @visited
  end
  it "一覧画面へリクエストが成功する" do
    get notifications_path
    expect(response.status).to eq 200
  end

  it "index画面にフォローの通知が表示される" do
    Notification.create(visitor_id: @visitor.id, visited_id: @visited.id)
    get notifications_path
    expect(response.body).to include @visitor.name
  end
  it "index画面にコメントの通知が表示される" do
    Notification.create(visitor_id: @visitor.id, visited_id: @visited.id, answer_id: @answer.id, comment_id: @comment.id)
    get notifications_path
    expect(response.body).to include @visitor.name
  end
end
