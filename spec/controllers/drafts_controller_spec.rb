require 'rails_helper'

RSpec.describe DraftsController, :type => :controller do
  context '記事の作成、編集、公開' do
    before do
      @user1 = User.create!(email: 'user1@mail.com')
      @user2 = User.create!(email: 'user2@mail.com')
    end
    
    it '下書きとの作成' do

    end
  end
end
