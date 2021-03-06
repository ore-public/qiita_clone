require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  context '記事へのアクセス' do
    render_views

    before do
      @user1 = FactoryGirl.create(:user1)
      @user2 = FactoryGirl.create(:user2)

      draft1 = @user1.drafts.build(title: 'ユーザー1の記事')
      draft1.public = true
      draft1.save!
      @item1 = draft1.save_item

      draft2 = @user2.drafts.build(title: 'ユーザー2の記事')
      draft2.public = true
      draft2.save!
      @item2 = draft2.save_item
    end

    it '自分の記事にアクセスした場合、編集リンクが表示されること' do
      sign_in @user1

      get :show, {id: @item1.to_param}
      expect(response.body).to match /編集/
    end

    it '他人の記事にアクセスした場合、編集リンクが表示されないこと' do
      sign_in @user2

      get :show, {id: @item1.to_param}
      expect(response.body).not_to match /編集/
    end

  end
end
