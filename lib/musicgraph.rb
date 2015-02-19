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
end
