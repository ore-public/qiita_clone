require 'rails_helper'

describe Article, type: :model do

  it "下書き記事を作成、item_token, slugが生成されること" do
    draft = Draft.create!(title: '下書き')
    expect(draft.item_token).not_to eq(nil)
    expect(draft.slug).not_to eq(nil)
  end

  it "同じitem_tokenでデータが出来ても, slugが異なること" do
    draft1 = Draft.create!(title: '下書き1', item_token: 'hoge')
    draft2 = Draft.create!(title: '下書き2', item_token: 'hoge')
    expect(draft1.slug).not_to eq(draft2.slug)
  end

  it "下書きと公開記事、item_tokenが同じなら、slugも同じになること" do
    draft = Draft.create!(title: '下書き')
    item = Item.create!(draft.get_contents)
    expect(item.slug).to eq(draft.slug)
  end
  
end
