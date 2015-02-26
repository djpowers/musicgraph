module MusicGraph
  class Album
    attr_reader :title

    API_URL = "http://api.musicgraph.com/api/v2/album/"

    def initialize(attributes)
      @title = attributes["title"]
    end

    def self.search(params)
      response = Faraday.get("#{API_URL}search?#{MusicGraph.key_param}&title=#{params}")
      albums = JSON.parse(response.body)["data"]
      albums.map { |attributes| new(attributes) }
    end
  end
end
