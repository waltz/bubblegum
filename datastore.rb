# Provides an interface through which other parts of the application
# can access and modify persistent data.
class DataStore
  # Automagic accessors for class data.
  attr_reader :public_key, :private_key, :port
  attr_writer :public_key, :private_key, :port
  
  # Try to read the settings from disk on instantiation.
  def initialize
  end
  
  # Writes the settings back out to the disk.
  # NOTE: Call this function before destroying the class.
  def destroy
  end
  
end