require 'rails_helper'

describe Article, type: :model do

  before do
    @user = FactoryGirl.create(:user1)
  end

  it "下書き記事を作成、item_token, slugが生成されること" do
    draft = @user.drafts.build(title: '下書き')
    draft.save!
    expect(draft.item_token).not_to eq(nil)
    expect(draft.slug).not_to eq(nil)
  end

  it "同じitem_tokenでデータが出来ても, slugが異なること" do
    draft1 = @user.drafts.build(title: '下書き1', item_token: 'hoge')
    draft1.save!
    draft2 = @user.drafts.build(title: '下書き2', item_token: 'hoge')
    draft2.save!
    expect(draft1.slug).not_to eq(draft2.slug) 
  end

  context '下書きから公開記事を作る（記事が未公開の場合)' do
    it '下書きから公開記事作成。下書きの内容と同じであること' do
      draft = @user.drafts.build(title: '下書き', raw_body: '# タイトル')
      draft.save!
      item = draft.public_item!
      expect(item).to be_persisted
      expect(item.title).to eq(draft.title)
      expect(item.raw_body).to eq(draft.raw_body)
      expect(item.item_token).to eq(draft.item_token)
      expect(item.slug).to eq(draft.slug)
    end

    it 'item_tokenが重複した下書きがある場合、公開記事のslugが下書きと同期とれていること' do
      draft = @user.drafts.build(title: '下書き', item_token: 'hoge')
      draft.save!
      item = draft.public_item!
      draft2 = @user.drafts.build(title: '下書き2', item_token: 'hoge')
      draft2.save!
      item2 = draft2.public_item!
      expect(item.slug).to eq(draft.slug)
      expect(item2.slug).to eq(draft2.slug)
    end

  end

  context '下書きの編集結果を公開記事に反映する(記事が公開済みの場合)' do
    it '記事を公開後、下書きの編集をして公開記事を更新出来ること' do
      draft = @user.drafts.build(title: 'タイトル')
      draft.save!
      draft.public_item!

      draft.title = 'タイトル upd'
      draft.raw_body = '本文 upd'
      draft.save!
      item = draft.public_item!

      expect(item.title).to eq('タイトル upd')
      expect(item.raw_body).to eq('本文 upd')
    end
  end
end
