require 'rails_helper'

describe 'top画面のテスト' do
  before do
    visit root_path
  end
  it "root_pathが/か" do
    expect(root_path).to eq('/')
  end
    # it "userが表示されているか、ニックネームにリンク適用されているか" do
    #   expect(page).to have_content user.name
    #   expect(page).to have_link user.name
    # end
end