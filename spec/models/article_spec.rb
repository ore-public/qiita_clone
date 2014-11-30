require 'spec_helper'

describe 'Article' do

  it "下書き記事を作成、item_token, slugが生成されること" do
    draft = Draft.create!(title: '下書き')

  end
end