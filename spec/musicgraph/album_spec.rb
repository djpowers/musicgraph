module MusicGraph
  describe Album do

    it "exists" do
      expect(MusicGraph::Album)
    end

    describe "#search" do
      it "returns album title search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          album_name = "either/or"
          albums = MusicGraph::Album.search(album_name)

          expect(albums).to_not be_empty
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Either/Or")
        end
      end

      it "accepts hash and returns album title search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            title: "i and love and you"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("I and Love and You")
        end
      end

      it "accepts hash and returns artist name search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            artist_name: "led zeppelin"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(20)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("C'mon Everybody")
          expect(albums.last.title).to eql("Led Zeppelin [Box Set]")
        end
      end
    end
  end
end
