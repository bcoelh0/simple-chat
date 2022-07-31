class Members
  include Enumerable

  def initialize()
    @members = []
  end

  def each
    @members.each { |member| yield member }
  end

  def add(member)
    @members << member
  end

  def remove(member)
    @members.delete(member)
  end

  def broadcast(message, sender)
    receivers = @members - [sender]
    sender.prompt
    receivers.each do |receiver|
      receiver.push_message("> #{sender.username}: #{message}")
    end
  end

  def register(socket)
    member = create_member(socket)
    return if member.nil?

    member.welcome_from(@members)
    add(member)
    broadcast("[joined]", member)
    member
  end

  def listen(member)
    loop { broadcast(member.listen, member) }
  end

  def disconnect(member)
    broadcast("[left]", member)
    remove(member)
    member.disconnect
  end

  private

  def create_member(socket)
    socket.print "What's your name? "
    begin
      username = socket.gets.chomp
      Member.new(username, socket)
    rescue
      member = Member.new("", socket)
      member.disconnect
      # raise "DISCONNECT!"
      return nil
    end
  end
end
