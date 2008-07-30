# A persistent data store for the rest of the bubblegum app.
# Mostly sits on top of SQLite.
class Grocer
  # Automagic accessors for class data.
  attr_reader :public_key, :private_key, :port
  attr_writer :public_key, :private_key, :port, :listen_addr
  
  # Try to read the settings from disk on instantiation.
  def initialize
  end
  
  # Writes the settings back out to the disk.
  # NOTE: Call this function before destroying the class.
  def destroy
  end
  
  
end