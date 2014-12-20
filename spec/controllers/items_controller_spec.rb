require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  context '記事へのアクセス' do
    before do
      @user1 = User.create!(email: 'user1@mail.com')
      @user2 = User.create!(email: 'user2@mail.com')

      draft1 = @user1.drafts.build(title: 'ユーザー1の記事')
      draft1.save!
      @item1 = draft1.new_public_item

      draft2 = @user2.drafts.build(title: 'ユーザー2の記事')
      draft2.save!
      @item2 = draft2.new_public_item
    end

    it '自分の記事にアクセスした場合' do
      sign_in @user1

      get :show, {id: @item1.to_param}
      expect(response).to render_template(:show)
    end

    it '他人の記事にアクセスした場合' do
      sign_in @user1

    end
  end
end
