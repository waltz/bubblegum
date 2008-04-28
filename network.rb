# UDP Server

require 'socket'
require 'openssl'

port = 4500

conn = UDPSocket.open

conn.bind(nil, port)

puts "Server started and waiting..."

#7.times {p conn.recvfrom(1)[0]}

# Reads a message from the socket.
def parse(conn)
  message = {}
  consumed = conn.recvfrom(4)[0]
  message['length'] = consumed
  message['command'] = conn.recvfrom(16)[0]
  consumed = consumed - 16
  message['']
end