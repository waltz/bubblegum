require 'yaml'

# Stores a user's preferences. Handles the reading and writing of prefs to/from a file.
class Preferences
  include Singleton
  
  # Automagic accessors for class data.
  attr_reader :public_key, :private_key, :port
  attr_writer :public_key, :private_key, :port
  
  # Try to read the settings from disk on instantiation.
  def initialize
    @filename = '../prefs.yaml'
    load
  end
  
  # Saves the preferences out to a YAML file.
  def save
    begin
      prefs_file = File.new(@filename, "w")
      prefs_file.write(raw_prefs)
      prefs_file.close
    rescue Exception => e
      puts "There was an error saving the preferences file!"
    end
  end
  
  def load
    raw_prefs = YAML.load_file(@filename)
  end
  
  def raw_prefs
    [@public_key, @private_key, @port, @openid_username, @shared_dir, @download_dir]
  end
  
  def raw_prefs=(prefs)
    @public_key, @private_key, @port, @openid_username, @shared_dir, @download_dir = prefs
  end
  
end