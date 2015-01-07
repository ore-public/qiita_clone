require 'rails_helper'

RSpec.describe Stock, :type => :model do
  context '記事とユーザーの1対多関連' do
    before do
      @create_user = User.create!(email: 'create_user@email.com')
      draft = @create_user.drafts.build(title: '記事')
      draft.save!
      @item = draft.new_public_item

      @stock_user1 = User.create!(email: 'stock_user1@email.com')
      @stock_user2 = User.create!(email: 'stock_user2@email.com')

      @stock_user1.stock_items << @item
      @stock_user2.stock_items << @item

    end
    it '公開記事に複数ユーザーがストックしていること' do
      expect(@item.stock_users.count).to eq(2)
    end
  end

  context 'ユーザーと記事の1対多関連' do
    before do
      @create_user = User.create!(email: 'create_user@email.com')
      draft1 = @create_user.drafts.build(title: '記事')
      draft1.save!
      @item1 = draft1.new_public_item

      draft2 = @create_user.drafts.build(title: '記事2')
      draft2.save!
      @item2 = draft2.new_public_item

      @stock_user1 = User.create!(email: 'stock_user1@email.com')

      @stock_user1.stock_items << @item1
      @stock_user1.stock_items << @item2

    end
    it '公開記事に複数ユーザーがストックしていること' do
      expect(@stock_user1.stock_items.count).to eq(2)
    end
  end
end
