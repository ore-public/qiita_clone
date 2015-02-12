require 'rails_helper'

RSpec.describe DraftsController, :type => :controller do
  let(:drafts_attributes) {
    {title: '下書き', raw_body: ''}
  }

  context '記事の作成、編集、公開' do
    before do
      @user1 = FactoryGirl.create(:user1)
      @user2 = FactoryGirl.create(:user2)
    end

    it '下書きの作成' do
      sign_in @user1

      expect {
        post :create, {draft: drafts_attributes}
      }.to change(Draft, :count).by(1)
    end

    context '下書き保存せずすぐに公開' do
      before do
        sign_in @user1
        @result = expect do
          post :create, {draft: {title: '公開新規'}, public_create: '投稿'}
        end
      end

      it { @result.to change(Item, :count).by(1) }
      it { @result.to change(Draft, :count).by(1) }
    end

    it '下書きを編集して公開' do
      sign_in @user1

      draft = @user1.drafts.build(drafts_attributes)
      draft.save!

      expect {
        put :update, {id: draft.id, draft: {title: '編集して公開'}, public_create: '投稿'}
      }.to change(Item, :count).by(1)
    end

    context '公開記事を編集して下書きのみ保存した場合' do
      before do
        sign_in @user1

        draft = @user1.drafts.build(drafts_attributes)
        draft.save!
        item = draft.public_item!
        @slug = item.slug

        put :update, {id: draft.id, draft: {title: '公開記事を下書き保存'}}
      end

      it '下書きのみ更新されていること' do
        item = Item.find_by!(slug: @slug)
        draft = Draft.find_by!(slug: @slug)

        expect(item.title).not_to eq(draft.title)
      end
    end

    context '公開記事の編集から公開記事を保存した場合' do
      before do
        sign_in @user1

        draft = @user1.drafts.build(drafts_attributes)
        draft.save!
        item = draft.public_item!
        @slug = item.slug

        put :update, {id: draft.id, draft: {title: '公開記事を下書き保存'}, public_update: '更新'}
      end

      it '下書きと公開記事が更新されていること' do
        item = Item.find_by!(slug: @slug)
        draft = Draft.find_by!(slug: @slug)

        expect(item.title).to eq(draft.title)
      end
    end
  end
end
