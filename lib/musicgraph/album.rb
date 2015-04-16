module MusicGraph
  class Album
    attr_reader :title, :release_year, :entity_type, :album_artist_id, :id, :number_of_tracks, :album_ref_id, :performer_name, :main_genre, :product_form

    API_URL = "http://api.musicgraph.com/api/v2/album/"

    def initialize(attributes)
      @title = attributes["title"]
      @title = attributes["name"] if attributes["name"]
      @release_year = attributes["release_year"]
      @entity_type = attributes["entity_type"]
      @album_artist_id = attributes["album_artist_id"]
      @id = attributes["id"]
      @number_of_tracks = attributes["number_of_tracks"]
      @album_ref_id = attributes["album_ref_id"]
      @performer_name = attributes["performer_name"]
      @main_genre = attributes["main_genre"]
      @product_form = attributes["product_form"]
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

    def self.find(id, filters = nil)
      request = "#{API_URL}#{id}?#{MusicGraph.key_param}"
      request += "&fields=#{filters.join(",")}" if filters
      response = Faraday.get(request)
      attributes = JSON.parse(response.body)
      new(attributes["data"])
    end

    def edges
      response = Faraday.get("#{API_URL}#{id}/edges?#{MusicGraph.key_param}")
      JSON.parse(response.body)["data"]
    end

    def metadata
      response = Faraday.get("#{API_URL}#{id}?#{MusicGraph.key_param}")
      JSON.parse(response.body)["data"]
    end
  end
end
