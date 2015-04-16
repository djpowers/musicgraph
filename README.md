# MusicGraph

A Ruby gem to access the [MusicGraph API](https://developer.musicgraph.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'musicgraph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install musicgraph

## Usage

```ruby

MusicGraph.api_key = "[api key]"

artist = MusicGraph::Artist.search('kaiser chiefs').first
artist.name # => "Kaiser Chiefs"
artist.main_genre # => "rock"
artist.decade # => "2000s / 2010s"

artists = MusicGraph::Artist.search({similar_to: "Pink Floyd"})
artists.first.name # => "David Gilmour"
artists.last.name # => "Eric Clapton"

artists = MusicGraph::Artist.search({decade: "1990s"})
artists.first.name # => "Lil Wayne"

artists = MusicGraph::Artist.search({genre: "Soul/R&B"})
artists.last.name # => "Amy Winehouse"

artists = MusicGraph::Artist.search({gender: "female"})
artists.last.name # => "Shakira"

artists = MusicGraph::Artist.search({country: "wales"})
artists.last.name # => "Tom Jones"

artists = MusicGraph::Artist.search({limit: 5})
artists.length # => 5

artist = MusicGraph::Artist.suggest("king").last
artist.name # => "King James"

artist = MusicGraph::Artist.find("e4de0d41-a6b5-11e0-b446-00251188dd67")
artist.name # => "Beck"

artist.edges # => ["albums", "similar", "tracks"]

artist.metadata # => returns all available metadata

artist.similar.first # => "Bob Forrest"

artist.albums # => returns array of albums belonging to artist

artist.tracks # => returns array of tracks belonging to artist

artist = MusicGraph::Artist.find("e4de0d41-a6b5-11e0-b446-00251188dd67", ["id", "name"])
artist.name # => "Beck"
artist.gender # => nil

albums = MusicGraph::Album.search("either/or")
albums.first.title # => "Either/Or"

albums = MusicGraph::Album.search({artist_name: "led zeppelin"})
albums.first.title # => "C'mon Everybody"

albums = MusicGraph::Album.search({similar_to: "grace"})
albums.first.title # => "Tidal"

albums = MusicGraph::Album.search({country: "iceland"})
albums.first.title # => "My Head Is an Animal"

albums = MusicGraph::Album.search({decade: "1960s"})
albums.first.title # => "Soul Shakedown"

albums = MusicGraph::Album.search({genre: "rock"})
albums.first.title # => "You Are the Night"

albums = MusicGraph::Album.search({limit: 5}).last
albums.length # => 5

albums = MusicGraph::Album.suggest("emotion").
albums.first.title # => "Emotions"

album = MusicGraph::Album.find("7cfb88ac-1d50-f210-42d6-57a718fa141c")
albums.first.performer_name # => "The Rolling Stones"

album.edges # => ["artists", "tracks"]

album.metadata # => returns all available metadata

album.artists.first.name # => "The Rolling Stones"
```

## Testing

To configure the gem for testing, add the following to `.env`: `MUSICGRAPH_API_KEY=xyz` (where "xyz" is your MusicGraph API key)

## Contributing

1. Fork it ( https://github.com/[djpowers]/musicgraph/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
