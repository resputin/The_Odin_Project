require 'socket'
require 'json'
server = TCPServer.open(2000)
loop {
	client = server.accept
	begin
   request = client.read_nonblock(256)
	rescue IO::WaitReadable
   IO.select([client])
   retry
	end
	
	verb = request.scan(/\S+/)[0]
	path = request.scan(/\S+/)[1]

	if File.exist?(path)

		if verb == "GET"
			client.puts "HTTP/1.0 200 OK\nDate: #{Time.now.ctime}\nContent-Type: text/html\nContent-Length: #{File.open(path).read.to_s.length}\n#{File.open(path).read}"
		
		elsif verb == "POST"
			json_data = request.scan(/{.+/)[0]
			params = {} 
			params = JSON.parse(json_data)
			user_data = "<li>Name: #{params["viking"]["name"]}</li>\n<li>Email: #{params["viking"]["email"]}</li>"
			client.puts "HTTP/1.0 200 OK\nDate: #{Time.now.ctime}\nContent-Type: text/html\nContent-Length: #{File.open(path).read.to_s.length}\n#{File.open(path).read.gsub(/<%= yield %>/, user_data)}"
		end

	else
		client.puts "HTTP/1.0 404 Not Found"
	end
	client.close
}