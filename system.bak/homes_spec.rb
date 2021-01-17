# frozen_string_literal: true

require 'rails_helper'

describe 'top画面のテスト' do
  before do
    visit root_path
  end

  it "root_pathが/か" do
    expect(current_path).to eq('/')
  end
end
