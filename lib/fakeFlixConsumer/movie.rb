module FakeFlixConsumer
  class Movie
    attr_reader :title, :id, :image

    def initialize(props = {})
      @title = props[:title]
      @id = props[:id]
      @image = props[:image]
    end

    def == (other_movie)
      # garantindo que os objetos que estamos comparando sao filmes
      return false if self.class != other_movie.class
      id == other_movie.id &&
        title == other_movie.title &&
        image === other_movie.image
    end
  end
end