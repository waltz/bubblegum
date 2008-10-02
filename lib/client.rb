require 'xmlrpc/client'

# A simple command line client for bubblegum.
class Client
  
  def initialize
    @running = true
    get_input
  end
  
  def get_input
    while @running
      printf "bubblegum: "
      input = gets
      exec(input.chomp)
    end
  end
  
  def exec(command)
    return if command.size == 0 # Pressing enter should skip to a new prompt.
    
    command = command.split(" ")
    rest = command[1..-1]
    
    # Process the command.
    case command.first
      when "ping":
        ping
      when "link":
        link(rest)
      when "help":
        help(rest)
      when "about":
        about
      when "quit":
        quit
      when "\n":
        nil
      else
        puts "Huh. Don't know what that does. Try \"help\" if you're lost."
    end
  end
  
  def help(rest = nil)
    puts "Command Listing:"
    puts " * help: This!"
    puts " * about: A quick blurb about this software."
    puts " * quit: Exit the application."
  end
  
  def about(rest = nil)
    puts "Bubblegum is an easy to use secure darknet."
  end
  
  def quit(rest = nil)
    puts "Later dude!"
    @running = false
  end
  
  # Links this client instance with some bubblegum daemon
  def link(rest = nil)
    host = rest[0]
    port = rest[1]
    
    begin
      @daemon = XMLRPC::Client.new(host, nil, port, nil, nil, nil, nil, true, nil)
    rescue Exception => e
      puts "There was an error trying to connect to the daemon."
      puts e.inspect
    end
  end
  
  # Pings the server.
  def ping(rest = nil)
    if @daemon
      puts @daemon.call("bubblegum.ping")
    else
      puts "Not connected. Try \"link\" first."
    end
  end
  
end

