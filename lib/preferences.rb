require 'yaml'
require 'singleton'

# Stores a user's preferences. Handles the reading and writing of prefs to/from a file.
class Preferences
  include Singleton
  
  attr_accessor :public_key, :private_key, :port, :filename
  
  # Try to read the settings from disk on instantiation.
  def initialize
    @filename = File.dirname(__FILE__) + '/../prefs.yml'
    load
  end
  
  # Saves the preferences out to a YAML file.
  def save
    begin
      prefs_file = File.new(@filename, "w")
      YAML.dump(raw_prefs, prefs_file)
      #prefs_file.write(raw_prefs)
      prefs_file.close
    rescue Exception => e
      puts "There was an error saving the preferences file!"
    end
    @filename
  end
  
  def load
    if File.exists?(@filename)
      raw_prefs = YAML.load_file(@filename)
    else
      build_defaults
    end
    raw_prefs
  end
  
  def raw_prefs
    prefs = {}
    self.instance_variables.each { |x|
      prefs[x.sub(/^@/, '').to_sym] = self.instance_variable_get(x)
    }
    prefs
  end
  
  def raw_prefs=(prefs)
    @public_key, @private_key, @port, @openid_username, @shared_dir, @download_dir = prefs
  end
  
  def build_defaults
    raw_prefs = [nil, nil, "5050", nil, "../shared", "../downloads"]
    save
  end
  
  def to_yaml
    raw_prefs.to_yaml
  end
end