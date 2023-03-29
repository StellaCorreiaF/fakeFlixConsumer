RSpec.describe FakeFlixConsumer::Client do
  subject(:client) { FakeFlixConsumer::Client.new }
  describe "#show_movie" do
    it "busca filme por id" do
      VCR.use_cassette("movie_1") do

        movie = client.show_movie(1)

        expect(movie).to eq FakeFlixConsumer::Movie.new(
          id: 1,
          title: "O auto da compadecida",

        )
      end
    end
  end
  describe "#list_movies" do
    it "lista todos os filmes" do
      VCR.use_cassette("list") do

        list = client.list_movies
        expect(list).to eq [
                             FakeFlixConsumer::Movie.new(
                               id: 1,
                               title: "O auto da compadecida"
                             ),
                             FakeFlixConsumer::Movie.new(
                               id: 2,
                               title: "Matrix"
                             ), FakeFlixConsumer::Movie.new(
                             id: 3,
                             title: "Django Livre"
                           )
                           ]

      end
    end
  end

  describe "#createMovie" do
    it "cadastra um fime" do
      movie = client.create_movie(
        title: "Titanic",
        director_id: 3,
        genre_id: 2
      )
      expect(movie.title).to eq "Titanic"
      expect(movie.id).to_not eq nil

    end

  end

  describe "#list_movies_by_genre" do
    it "lista filmes por genero" do
      movies = client.list_movies_by_genre(2)
      expect(movies).to eq [
                           FakeFlixConsumer::Movie.new(
                             title: "Titanic",
                             genre_id: 2
                         )
                         ]
    end
  end
end
