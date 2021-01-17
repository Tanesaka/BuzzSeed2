require 'rails_helper'

describe 'Themes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @answer = FactoryBot.create(:answer)
    @theme = @answer.theme
  end

  after do
    sign_out @user
  end

  it "show画面にお題画像が表示される" do
    get theme_path(@theme)
    expect(response.body).to include @theme.image_id
  end
  it "show画面にお題に紐づくヒトコトの表示がある" do
    get theme_path(@theme)
    expect(response.body).to include @answer.content
  end
  it "show画面にお題に紐づくヒトコト数の表示がある" do
    get theme_path(@theme)
    expect(response.body).to include "#{@theme.answers.count}"
  end
  it "一覧画面にお題画像が表示される" do
    get themes_path
    expect(response.body).to include @theme.image_id
  end
end
