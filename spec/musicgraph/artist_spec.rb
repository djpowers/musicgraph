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

  end
end
