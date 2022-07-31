require 'socket'

class Client
  def self.run
    new.run
  end

  def run
    puts "connecting..."
    server = TCPSocket.new 'localhost', 2000

    response = Thread.new do
      while (line = server.gets) do
        puts(line)
      end
    end

    request = Thread.new do
      while (input = gets) do
        server.puts(input)
      end
    end

    response.join
    request.join
  end
end

Client.run
