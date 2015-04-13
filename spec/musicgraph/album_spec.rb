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

      it "accepts hash and returns offset results" do
        VCR.use_cassette("album", record: :new_episodes) do
          params = {
            similar_to: "Sgt. Pepper's Lonely Hearts Club Band",
            offset: 5
          }
          albums = MusicGraph::Album.search(params)

          expect(albums).to_not be_empty
          expect(albums.length).to eql(8)
          expect(albums.first).to be_a Album
          expect(albums.first.title).to_not eql("Days of Future Passed")
          expect(albums.last.title).to eql("Are You Experienced?")
        end
      end
    end

    describe "#suggest" do
      it "returns a list of matches" do
        VCR.use_cassette("album", record: :new_episodes) do
          query = "Emotion"
          albums = MusicGraph::Album.suggest(query)

          expect(albums.length).to eql(20)
          expect(albums).to be_a Array
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Emotions")
        end
      end

      it "accepts hash and returns suggestions" do
        VCR.use_cassette("artist", record: :new_episodes) do
          params = {
            prefix: "Emotion"
          }
          albums = MusicGraph::Album.suggest(params)

          expect(albums.length).to eql(20)
          expect(albums).to be_a Array
          expect(albums.first).to be_a Album
          expect(albums.first.title).to eql("Emotions")
        end
      end
    end

    describe "#find" do
      it "returns a single album" do
        VCR.use_cassette("album", record: :new_episodes) do
          album_id = "7cfb88ac-1d50-f210-42d6-57a718fa141c"
          album = MusicGraph::Album.find(album_id)

          expect(album).to be_an Album
          expect(album.release_year).to eql(1980)
          expect(album.title).to eql("Emotional Rescue")
          expect(album.entity_type).to eql("album")
          expect(album.album_artist_id).to eql("e88b6841-a6b5-11e0-b446-00251188dd67")
          expect(album.id).to eql("7cfb88ac-1d50-f210-42d6-57a718fa141c")
          expect(album.number_of_tracks).to eql("10")
          expect(album.album_ref_id).to eql("32202849")
          expect(album.performer_name).to eql("The Rolling Stones")
          expect(album.main_genre).to eql("rock")
          expect(album.product_form).to eql("Album")
        end
      end
    end

    describe "#edges" do
      it "returns edges for an album" do
        VCR.use_cassette("album", record: :new_episodes) do
          album_id = "7cfb88ac-1d50-f210-42d6-57a718fa141c"
          album = MusicGraph::Album.find(album_id)

          expect(album.edges).to be_an Array
          expect(album.edges).to eql(["artists", "tracks"])
        end
      end
    end

    describe "#metadata" do
      it "returns metadata for an album" do
        VCR.use_cassette("album", record: :new_episodes) do
          album_id = "7cfb88ac-1d50-f210-42d6-57a718fa141c"
          album = MusicGraph::Album.find(album_id)

          expect(album.metadata).to be_a Hash
        end
      end
    end
  end
end
