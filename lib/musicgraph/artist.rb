require "faraday"
require "json"
require "uri"

API_URL = "http://api.musicgraph.com/api/v2/artist/"

module MusicGraph
  class Artist
    attr_reader :seven_digital_id, :main_genre, :country_of_origin, :entity_type, :artist_ref_id, :vevo_id, :sort_name, :gender, :rhapsody_id, :id, :decade, :name

    def initialize(attributes)
      @seven_digital_id = attributes["7digital_id"]
      @main_genre = attributes["main_genre"]
      @country_of_origin = attributes["country_of_origin"]
      @entity_type = attributes["entity_type"]
      @artist_ref_id = attributes["artist_ref_id"]
      @vevo_id = attributes["vevo_id"]
      @sort_name = attributes["sort_name"]
      @gender = attributes["gender"]
      @rhapsody_id = attributes["rhapsody_id"]
      @id = attributes["id"]
      @decade = attributes["decade"]
      @name = attributes["name"]
    end

    def self.search(params)
      if params.is_a? String
        response = Faraday.get("#{API_URL}search?#{MusicGraph.key_param}&name=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}search?#{MusicGraph.key_param}&#{encoded_params}")
      end
      artists = JSON.parse(response.body)["data"]
      artists.map { |attributes| new(attributes) }
    end

    def self.suggest(params)
      if params.is_a? String
        response = Faraday.get("#{API_URL}suggest?#{MusicGraph.key_param}&prefix=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}suggest?#{MusicGraph.key_param}&#{encoded_params}")
      end
      artists = JSON.parse(response.body)["data"]
      artists.map { |attributes| new(attributes) }
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

    def similar
      response = Faraday.get("#{API_URL}#{id}/similar?#{MusicGraph.key_param}")
      artists = JSON.parse(response.body)["data"]
      artists.map { |attributes| Artist.new(attributes) }
    end

    def albums
      response = Faraday.get("#{API_URL}#{id}/albums?#{MusicGraph.key_param}")
      albums = JSON.parse(response.body)["data"]
      albums.map { |attributes| Album.new(attributes) }
    end

    def tracks
      response = Faraday.get("#{API_URL}#{id}/albums?#{MusicGraph.key_param}")
      albums = JSON.parse(response.body)["data"]
      albums.map { |attributes| Track.new(attributes) }
    end
  end
end
