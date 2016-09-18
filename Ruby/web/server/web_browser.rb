require 'socket'
require 'json'
host = 'localhost'     # The web server
port = 2000                          # Default HTTP port
puts "What would you like to do?"
verb = gets.chomp

puts "What path would you like?"
path = gets.chomp
if verb == "POST"
	puts "What's his name"
	name = gets.chomp
	puts "What's his email?"
	email = gets.chomp
	posted = {:viking => {:name=>name, :email=>email}}
	request = "POST #{path} HTTP/1.0\r\nContent-Type: x-www-form-urlencoded\nContent-Length: #{posted.to_json.length}\n\n#{posted.to_json}"
else
	request = "GET #{path} HTTP/1.0\r\n\r\n"
end

socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read
puts response                         # And display it
