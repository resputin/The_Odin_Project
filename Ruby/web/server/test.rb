require 'socket'
require 'json'
host = 'localhost'     # The web server
port = 2000  
posted = {"viking":{"name":"Erik","email":"Erik@code.com"}}
request = "POST thanks.html HTTP/1.0\r\nContent-Type: x-www-form-urlencoded\nContent-Length: 50\n\n#{posted}"
socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read
puts response  