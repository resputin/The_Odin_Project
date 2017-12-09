require 'rest-client'
url = 'http://localhost:3000/users/1/show'
puts RestClient.post(url, '')