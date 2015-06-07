require "faraday"
require "json"
require "uri"

require "musicgraph/version"
require "musicgraph/artist"
require "musicgraph/album"
require "musicgraph/track"

begin
  require "pry"
rescue LoadError
end

module MusicGraph

  def self.api_key=(key)
    @api_key = key
  end

  def self.api_key
    @api_key
  end

  protected
  def self.key_param
    begin
      "api_key=" + MusicGraph.api_key
    rescue
      raise "No MusicGraph API key present (MusicGraph.api_key='xyz')"
    end
  end
end
