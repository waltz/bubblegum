require 'webrick'
require 'webrick/https'
require 'xmlrpc/server'
require File.dirname(__FILE__) + '/./preferences'

# Small https server that is the main control interface for the Bubblegum peer.
class Server
  
  def initialize
    @prefs = Preferences.instance
    start_server
  end
  
  def start_server
    # Build the WEBrick server.
    @webrick = WEBrick::HTTPServer.new(
      :Port => @prefs.port,
      :Documentroot => nil,
      :SSLEnable => true,
      :SSLVerifyClient => ::OpenSSL::SSL::VERIFY_NONE,
      :SSLCertName => [["C", "US"], ["O", "Bubblegum"], ["CN", "WWW"]])
  
    # Build the XMLRPC servlet and attach it to WEBrick.
    @webrick.mount("RPC2", build_xmlrpc)
    
    @thread = Thread.new {
      @webrick.start
    }
  end
  
  # Turn off the https server.
  def shutdown
    @webrick.shutdown
    @thread.exit
  end
  
  # Builds the XMLRPC servlet.
  def build_xmlrpc
    xmlrpc = XMLRPC::WEBrickServlet.new
    
    xmlrpc.add_handler("bubblegum.ping") do
      "Pong!"
    end
    
    xmlrpc
  end
  
end
