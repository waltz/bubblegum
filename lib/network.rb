# doorman.rb
# The doorman waits for connections on some port and handles their queries.
# Based off of the ruby gserver code.

require 'socket'
require 'thread'
require 'bencode'

class Network
  @port = "6666"
  @listen_addr = "localhost"
  @pool # Active server threads.
  @pool_mutex = Mutex.new
  @stopped = false
  
  def initialize()
    @server = TCPServer.new(@listen_addr, @port)
    self.start_server
  end
  
  # Watch the TCP server for incoming connections and spawn new threads to
  # handle the incoming requests. The serve method is passed the connection
  # socket for each new incoming request.
  def start_server
    @watchman = Thread.new {
      while !@stopped
        @pool_mutex.synchronize
        socket = @server.accept
        @pool << Thread.new(socket) {|socket|
          serve(socket)
        }
      end        
    }
  end
  
  # Shut down the server. Sets the 'stopped' flag and forces any thread in
  # pool to stop execution.
  def shutdown
    @stopped = false
  end
  
  # Deal with the incoming requests.
  def serve(socket)
    size = socket.recvfrom(3)
    payload = socket.recvfrom(size)
    payload.bdecode
    puts payload[0]
  end
end

