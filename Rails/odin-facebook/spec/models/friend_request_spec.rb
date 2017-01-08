require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'sending a friend request' do
    it 'creates a friend request' do
      u1 = create(:user, email: Faker::Internet.unique.email)
      u2 = create(:user, email: Faker::Internet.unique.email)
      FriendRequest.create(sender_id: u1.id, receiver_id: u2.id)
      expect(FriendRequest.count).to eq(1)
    end

    it 'only allows one friend request per relationship' do
      u1 = create(:user, email: Faker::Internet.unique.email)
      u2 = create(:user, email: Faker::Internet.unique.email)
      FriendRequest.create(sender_id: u1.id, receiver_id: u2.id)
      FriendRequest.create(sender_id: u2.id, receiver_id: u1.id)
      expect(FriendRequest.count).to eq(1)
    end
  end
end
