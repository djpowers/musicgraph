require "spec_helper"

module MusicGraph
  describe Artist do
    let(:musicgraph) { MusicGraph::API.new(ENV["API_KEY"]) }

    it "exists" do
      expect(Artist)
    end

    describe "#search" do
      it "returns artist name search results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          artist_name = "wilco"
          artists = MusicGraph::Artist.search(artist_name)

          expect(artists).to_not be_empty
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Wilco")
        end
      end

      it "accepts hash and returns artist name search results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            name: "local natives"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Local Natives")
        end
      end

      it "accepts hash and returns similar to search results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            similar_to: "Pink Floyd"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(20)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("David Gilmour")
          expect(artists.last.name).to eql("Eric Clapton")
        end
      end

      it "accepts hash and returns decade results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            decade: "1990s"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(20)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Lil Wayne")
          expect(artists.last.name).to eql("Juicy J")
        end
      end

      it "accepts hash and returns genre results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            genre: "Soul/R&B"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(20)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Chris Brown")
          expect(artists.last.name).to eql("Amy Winehouse")
        end
      end

      it "accepts hash and returns gender results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            gender: "female"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(20)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Sasha")
          expect(artists.last.name).to eql("Shakira")
        end
      end

      it "accepts hash and returns country results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            country: "america"
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(20)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Lil Wayne")
          expect(artists.last.name).to eql("Juicy J")
        end
      end

      it "accepts hash and returns limited results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            similar_to: "Pink Floyd",
            limit: 5
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(5)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("David Gilmour")
          expect(artists.last.name).to_not eql("Eric Clapton")
        end
      end

      it "accepts hash and returns offset results" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            similar_to: "Pink Floyd",
            offset: 5
          }
          artists = MusicGraph::Artist.search(params)

          expect(artists).to_not be_empty
          expect(artists.length).to eql(7)
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to_not eql("David Gilmour")
          expect(artists.last.name).to eql("Hess Is More")
        end
      end
    end

    describe "#suggest" do
      it "returns a list of matches" do
        VCR.use_cassette("artist", record: :new_episodes) do
          query = "gree"
          artists = MusicGraph::Artist.suggest(query)

          expect(artists.length).to eql(20)
          expect(artists).to be_a Array
          expect(artists.first).to be_a Artist
          expect(artists.first.name).to eql("Green Day")
        end
      end
    end

    it "accepts hash and returns suggestions" do
      VCR.use_cassette("artist", record: :new_episodes) do
        params = {
          prefix: "gree"
        }
        artists = MusicGraph::Artist.suggest(params)

        expect(artists.length).to eql(20)
        expect(artists).to be_a Array
        expect(artists.first).to be_a Artist
        expect(artists.first.name).to eql("Green Day")
      end
    end
  end

  describe "#find" do
    it "returns a single artist" do
      VCR.use_cassette("artist", record: :new_episodes) do
        artist_id = "e4de0d41-a6b5-11e0-b446-00251188dd67"
        artist = MusicGraph::Artist.find(artist_id)

        expect(artist).to be_a Artist
        expect(artist.seven_digital_id).to eql("5843")
        expect(artist.main_genre).to eql("alternative/indie")
        expect(artist.country_of_origin).to eql("United States of America")
        expect(artist.entity_type).to eql("artist")
        expect(artist.artist_ref_id).to eql("2918")
        expect(artist.vevo_id).to eql("05158a95-fe62-42df-8359-e4b6a2c8bf5d")
        expect(artist.sort_name).to eql("Beck")
        expect(artist.gender).to eql("Male")
        expect(artist.rhapsody_id).to eql("7053")
        expect(artist.id).to eql("e4de0d41-a6b5-11e0-b446-00251188dd67")
        expect(artist.decade).to eql("1990s / 2000s / 2010s")
        expect(artist.name).to eql("Beck")
      end
    end
  end


  describe "#edges" do
    it "returns edges for an artist" do
      VCR.use_cassette("artist", record: :new_episodes) do
        artist = MusicGraph::Artist.find("e4de0d41-a6b5-11e0-b446-00251188dd67")

        expect(artist.edges).to be_a Array
        expect(artist.edges).to eql(["albums", "similar", "tracks"])
      end
    end
  end

  describe "#metadata" do
    it "returns avilable metadata for an artist" do
      VCR.use_cassette("artist", record: :new_episodes) do
        artist = MusicGraph::Artist.find("e4de0d41-a6b5-11e0-b446-00251188dd67")

        expect(artist.metadata).to be_a Hash
      end
    end
  end
end
