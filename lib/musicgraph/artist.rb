require "faraday"
require "dotenv"
require "json"
require "uri"
Dotenv.load

API_URL = "http://api.musicgraph.com/api/v2/artist/"
KEY_PARAM = "api_key=" + ENV["API_KEY"]

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
        response = Faraday.get("#{API_URL}search?#{KEY_PARAM}&name=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}search?#{KEY_PARAM}&#{encoded_params}")
      end
      artists = JSON.parse(response.body)["data"]
      artists.map { |attributes| new(attributes) }
    end

    def self.suggest(params)
      if params.is_a? String
        response = Faraday.get("#{API_URL}suggest?#{KEY_PARAM}&prefix=#{params}")
      elsif params.is_a? Hash
        encoded_params = URI.encode_www_form(params)
        response = Faraday.get("#{API_URL}suggest?#{KEY_PARAM}&#{encoded_params}")
      end
      artists = JSON.parse(response.body)["data"]
      artists.map { |attributes| new(attributes) }
    end

    def self.find(id)
      response = Faraday.get("#{API_URL}#{id}?#{KEY_PARAM}")
      attributes = JSON.parse(response.body)
      new(attributes["data"])
    end
  end
end
