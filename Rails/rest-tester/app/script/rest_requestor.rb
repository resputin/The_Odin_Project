require 'rest-client'
index_url = "http://localhost:3000/users"
new_url = "http://localhost:3000/users/new"
edit_url = "http://localhost:3000/users/1/edit"
show_url = "http://localhost:3000/users/1"
create_url = "http://localhost:3000/users/"
puts RestClient.get(new_url)
puts RestClient.get(edit_url)
puts RestClient.get(show_url)
puts RestClient.post(create_url,"")