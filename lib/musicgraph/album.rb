module MusicGraph
  class Album
    attr_reader :title

    API_URL = "http://api.musicgraph.com/api/v2/album/"

    def initialize(attributes)
      @title = attributes["title"]
      @title = attributes["name"] if attributes["name"]
    end

    def self.search(params)
      if params.is_a? String
        response = Faraday.get("#{API_URL}search?#{MusicGraph.key_param}&title=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}search?#{MusicGraph.key_param}&#{encoded_params}")
      end
      albums = JSON.parse(response.body)["data"]
      albums.map { |attributes| new(attributes) }
    end

    def self.suggest(params)
      if params.is_a? String
        response = Faraday.get("#{API_URL}suggest?#{MusicGraph.key_param}&prefix=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}suggest?#{MusicGraph.key_param}&#{encoded_params}")
      end
      albums = JSON.parse(response.body)["data"]
      albums.map { |attributes| new(attributes) }
    end
  end
end
