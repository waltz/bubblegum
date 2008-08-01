require 'xmlrpc/client'

# A simple command line client for bubblegum.
class Client
  
  def initialize
    get_input
  end
  
  def get_input
    while 1
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
    exit
  end
  
end

