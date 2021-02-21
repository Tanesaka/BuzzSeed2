require 'rails_helper'

describe 'Homes', type: :request do
  before do
    @information = FactoryBot.create(:information)
  end


  it "Topにヒトコト、お題、Good合計数がある" do
    get root_path
    expect(response.body).to include "#{Answer.all.count}"
    expect(response.body).to include "#{Theme.all.count}"
    expect(response.body).to include "#{Favorite.all.count}"
  end
  it "Topに直近のInfomationがある" do
    get root_path
    expect(response.body).to include @information.content
  end
end
