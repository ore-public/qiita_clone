require 'rails_helper'

RSpec.describe DraftsController, :type => :controller do
  let(:drafts_attributes){
    {title: '下書き', raw_body: ''}
  }

  let(:public_create_attributes){
    {title: '公開新規', public_crate: '投稿'}
  }

  let(:public_update_attributes){
    {title: '公開更新', public_crate: '投稿'}
  }
  context '記事の作成、編集、公開' do
    before do
      @user1 = User.create!(email: 'user1@mail.com')
      @user2 = User.create!(email: 'user2@mail.com')
    end
    
    it '下書きの作成' do
      sign_in @user1

      expect {
        post :create, {:draft => drafts_attributes}
      }.to change(Draft, :count).by(1)
    end
  end
end
