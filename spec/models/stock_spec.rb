require 'rails_helper'

RSpec.describe Stock, :type => :model do
  context '記事とユーザーの1対多関連' do
    before do
      @create_user = FactoryGirl.create(:user1)
      draft = @create_user.drafts.build(title: '記事')
      draft.public = true
      draft.save!
      @item = draft.save_item

      @stock_user1 = FactoryGirl.create(:user2)
      @stock_user2 = FactoryGirl.create(:user3)

      @stock_user1.stock_items << @item
      @stock_user2.stock_items << @item

    end
    it '公開記事に複数ユーザーがストックしていること' do
      expect(@item.stock_users.count).to eq(2)
    end
  end

  context 'ユーザーと記事の1対多関連' do
    before do
      @create_user = FactoryGirl.create(:user1)
      draft1 = @create_user.drafts.build(title: '記事')
      draft1.public = true
      draft1.save!
      @item1 = draft1.save_item

      draft2 = @create_user.drafts.build(title: '記事2')
      draft2.public = true
      draft2.save!
      @item2 = draft2.save_item

      @stock_user1 = FactoryGirl.create(:user2)

      @stock_user1.stock_items << @item1
      @stock_user1.stock_items << @item2

    end
    it '公開記事に複数ユーザーがストックしていること' do
      expect(@stock_user1.stock_items.count).to eq(2)
    end
  end
end
