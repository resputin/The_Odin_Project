FactoryGirl.define do
  factory(:user) do
    name                   "Dylan"
    email                  "nielsen.dylan@gmail.com"
    password               "password"
    password_confirmation  "password"
  end
end