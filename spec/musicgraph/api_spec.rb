require "spec_helper"

module MusicGraph
  describe API do
    it "exists" do
      expect(API)
    end

    it "has an API key" do
      musicgraph = MusicGraph::API.new('abc123')
      expect(musicgraph.api_key).to eql('abc123')
    end
  end
end
