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

      it "accepts hash and returns similar to albums" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            similar_to: "grace"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(7)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Tidal")
          expect(albums.last.title).to eql("Greater Than")
        end
      end

      it "accepts hash and returns country search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            country: "iceland"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(20)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("For Now I Am Winter")
          expect(albums.last.title).to eql("My Head Is an Animal")
        end
      end

      it "accepts hash and returns decade search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            decade: "1960s"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(20)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Soul Shakedown")
          expect(albums.last.title).to eql("At Carnegie Hall")
        end
      end

      it "accepts hash and returns genre search results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            genre: "rock"
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(20)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("You Are the Night")
          expect(albums.last.title).to eql("Safety")
        end
      end

      it "accepts hash and returns limited results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            similar_to: "Sgt. Pepper's Lonely Hearts Club Band",
            limit: 5
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(5)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Days of Future Passed")
          expect(albums.last.title).to eql("Their Satanic Majesties Request")
        end
      end
    end
  end
end
