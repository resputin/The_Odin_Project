require 'rails_helper'

RSpec.describe FriendRequestsController do
  before :each do
    @u1 = create(:user, email: Faker::Internet.unique.email)
    @u2 = create(:user, email: Faker::Internet.unique.email)
  end

  describe 'GET#new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST#create' do
    let(:attributes) { { sender_id: @u1.id, receiver_id: @u2.id} }
    let(:params) { { friend_request: attributes} }

    it 'creates new friend request' do      
      post :create, params: params
      expect(FriendRequest.count).to eq(1)
    end

    it 'redirects to user index' do
      post :create, params: params
      expect(response).to redirect_to(users_path)
    end
  end
end