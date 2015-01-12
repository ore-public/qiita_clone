require 'rails_helper'

RSpec.describe Follow, :type => :model do
  context 'フォローする' do
    before do
      @follow_user = FactoryGirl.create(:user1)
      @followed_user1 = FactoryGirl.create(:user2)
      @followed_user2 = FactoryGirl.create(:user3)

      follow1 = @followed_user1.follows.build(follower_id: @follow_user.id)
      follow1.save!

      follow2 = @followed_user2.follows.build(follower_id: @follow_user.id)
      follow2.save!
    end

    it 'フォロー済みユーザーの一覧が取得出来ること' do
      expect(@followed_user1.followed?(@follow_user)).to be_truthy
      expect(@followed_user2.followed?(@follow_user)).to be_truthy
    end
  end
end
