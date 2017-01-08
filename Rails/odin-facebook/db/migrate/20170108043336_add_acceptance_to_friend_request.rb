class AddAcceptanceToFriendRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :friend_requests, :acceptance, :integer
  end
end
