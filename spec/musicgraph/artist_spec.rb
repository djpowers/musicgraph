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
    end

  end
end
