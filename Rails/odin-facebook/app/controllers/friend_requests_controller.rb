class FriendRequestsController < ApplicationController
  def new
    @friend_request = FriendRequest.new(friend_request_params)
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      redirect_to users_path
    else
      flash[:danger] = "Friend request not allowed"
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id, :acceptance)
  end
end
