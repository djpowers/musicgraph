module MusicGraph
  describe "api key" do

    it "must be assignable" do
      MusicGraph.api_key = 'new_key'
      expect(MusicGraph.api_key).to eql('new_key')
    end
  end
end
