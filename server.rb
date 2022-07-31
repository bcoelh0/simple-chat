require 'socket'
require './member'
require './members'

class Server
  def self.run
    new.run
  end

  def run
    port = 2000
    server = TCPServer.new(port)

    puts "Server running on port #{port}..."

    members = Members.new

    loop do
      tcp_socket = server.accept
      Thread.new(tcp_socket) do |socket|
        begin
          member = members.register(socket)
          if member.nil?
            socket.close
            return true
          end

          members.listen(member)
        rescue EOFError, IOError # error when a socket is disconnected
          members.disconnect(member)
        end
      end
    end
  end
end

Server.run
