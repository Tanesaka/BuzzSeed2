require 'rails_helper'

# AnswerとCommentも一部記載（ViewがAnswerコントローラーからのため）
describe 'Answers', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @comment = FactoryBot.create(:comment)
    @answer = @comment.answer
  end

  after do
    sign_out @user
  end

  context 'Viewに関するテスト' do
    it "show画面にヒトコト文が表示される" do
      get answer_path(@answer)
      expect(response.body).to include @answer.content
    end
    it "show画面にヒトコトのGood数が表示される" do
      get theme_path(@answer)
      expect(response.body).to include "#{@answer.favorites.count}"
    end
    it "show画面にヒトコトのコメント数が表示される" do
      get theme_path(@answer)
      expect(response.body).to include "#{@answer.comments.count}"
    end
    it "ヒトコトのshow画面にコメントが表示される" do
      get answer_path(@answer)
      expect(response.body).to include @comment.content
    end
    it "一覧画面にヒトコト文が表示される" do
      get answers_path
      expect(response.body).to include @answer.content
    end
  end

  context '削除に関するテスト' do
    it "answer削除のテスト" do
      expect { @answer.destroy }.to change(Answer, :count).by(-1)
    end
    it "comment削除のテスト" do
      expect { @comment.destroy }.to change(Comment, :count).by(-1)
    end
  end
end
