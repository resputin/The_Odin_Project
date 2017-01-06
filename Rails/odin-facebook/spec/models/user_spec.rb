require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    before(:each) do
      @user_attributes = FactoryGirl.attributes_for(:user)
    end

    it "should create a new instance of a user given valid attributes" do
      User.create!(@user_attributes)
    end
  end
end
