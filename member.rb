class Member
  attr_reader :username, :socket

  def initialize(username, socket)
    @username = username
    @socket = socket
  end

  def welcome_from(members)
    socket.puts "Welcome #{username}! There are #{members.count} members."
  end

  def push_message(message)
    socket.puts(message)
  end

  def prompt
    socket.print("> ")
  end

  def listen
    socket.readline
  end

  def disconnect
    socket.close
  end
end
