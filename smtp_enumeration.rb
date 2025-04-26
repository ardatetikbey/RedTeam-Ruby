require 'socket'

users = %w{
  root ftp operator msfadmin admin
  sysadmin sys root bin daemon
}

found = []

socket = TCPSocket.new('192.168.1.85', 25) # change this
banner = socket.recv(1024).chomp

users.each do |user|
  socket.send "VRFY #{user} \n\r", 0
  response = socket.recv(1024).chomp

  found << user if response.split[2] == user
end

socket.close

puts "Response :"
puts "Banner: #{banner}"
puts "Users found: \n#{found.join("\n")}"
