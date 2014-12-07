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
o end

  context '下書きから公開記事を作る（記事が未公開の場合)' do
    it '下書きから公開記事作成。下書きの内容と同じであること' do
      draft = Draft.create!(title: '下書き', raw_body: '# タイトル')
      item = draft.new_public_item
      expect(item).to be_persisted
      expect(item.title).to eq(draft.title)
      expect(item.raw_body).to eq(draft.raw_body)
      expect(item.item_token).to eq(draft.item_token)
      expect(item.slug).to eq(draft.slug)
    end

    it 'item_tokenが重複した下書きがある場合、公開記事のslugが下書きと同期とれていること' do
      draft = Draft.create!(title: '下書き', item_token: 'hoge')
      item = draft.new_public_item
      draft2 = Draft.create!(title: '下書き2', item_token: 'hoge')
      item2 = draft2.new_public_item
      expect(item.slug).to eq(draft.slug)
      expect(item2.slug).to eq(draft2.slug)
    end

    it 'すでに公開済みの下書きで、公開メソッドを呼ぶとエラーになること' do
      draft = Draft.create!(title: '下書き', raw_body: '# タイトル')
      draft.new_public_item
      expect{draft.new_public_item}.to raise_error
    end
  end

  context '下書きの編集結果を公開記事に反映する(記事が公開済みの場合)' do
    it '記事を公開後、下書きの編集をして公開記事を更新出来ること' do
      draft = Draft.create!(title: 'タイトル')
      draft.new_public_item

      draft.title = 'タイトル upd'
      draft.raw_body = '本文 upd'
      draft.save!
      draft.item.update_public_item

      item = draft.item
      expect(item.title).to eq('タイトル upd')
      expect(item.raw_body).to eq('本文 upd')
  end
end
