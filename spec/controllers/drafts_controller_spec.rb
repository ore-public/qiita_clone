require 'rails_helper'

RSpec.describe DraftsController, :type => :controller do
  let(:drafts_attributes) {
    {title: '下書き', raw_body: ''}
  }

  context '記事の作成、編集、公開' do
    before do
      @user1 = User.create!(email: 'user1@mail.com')
      @user2 = User.create!(email: 'user2@mail.com')
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
        post :update, {id: draft.id, draft: {title: '編集して公開'}, public_create: '投稿'}
      }.to change(Item, :count).by(1)
    end
  end
end
