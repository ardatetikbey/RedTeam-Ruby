require 'socket'

kullanıcılar = %w{
  root ftp operator msfadmin admin
  sysadmin sys root bin daemon
}

found = []

socket = TCPSocket.new('192.168.1.85', 25) # change this
banner = socket.recv(1024).chomp

kullanıcılar.each do |user|
  socket.send "VRFY #{user} \n\r", 0
  response = socket.recv(1024).chomp

  found << user if response.split[2] == user
end

socket.close

puts "Dönüt :"
puts "Banner: #{banner}"
puts "Bulunan Kullanıcılar: \n#{found.join("\n")}"
