require 'rails_helper'

describe 'informationモデルのテスト' do
  it "有効な登録内容の場合は保存されるか" do
    expect(FactoryBot.create(:information)).to be_valid
  end
  it "contentが空白の場合に空白のバリデーションチェックが行われるか" do
    admin = FactoryBot.create(:admin)
    information = Information.new(admin_id: admin.id, content: '')
    expect(information).to be_invalid
  end
end