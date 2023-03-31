RSpec.describe FakeFlixConsumer::Client do
  subject(:client) { FakeFlixConsumer::Client.new }
  describe "#show_movie" do
    it "busca filme por id" do
      VCR.use_cassette("movie_1") do

        movie = client.show_movie(1)

        expect(movie).to eq FakeFlixConsumer::Movie.new(
          id: 1,
          title: "O Auto da Compadecida",

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
                               title: "O Auto da Compadecida"
                             ),
                             FakeFlixConsumer::Movie.new(
                               id: 2,
                               title: "Matrix"
                             ), FakeFlixConsumer::Movie.new(
                             id: 3,
                             title: "Django Livre"
                           ),
                             FakeFlixConsumer::Movie.new(
                               id: 4,
                               title: "Antes do Amanhecer"
                             ),
                             FakeFlixConsumer::Movie.new(
                               id: 5,
                               title: "Titanic"
                             ),
                             FakeFlixConsumer::Movie.new(
                               id: 6,
                               title: "Lisbela e o Prisioneiro"
                             ),
                           ]

      end
    end
  end

  describe "#createMovie" do
    it "cadastra um fime" do
      VCR.use_cassette("create") do
        movie = client.create_movie(
          title: "Antes da Meia-Noite",
          genre_id: 2,
          director_id: 6,
        )
        expect(movie.title).to eq "Antes da Meia-Noite"
        expect(movie.id).to_not eq nil
      end
    end
  end

  describe "#list_movies_by_genre" do
    it "lista filmes por genero" do
      VCR.use_cassette("list_by_genre") do
        movies = client.list_movies_by_genre(2)
        expect(movies).to eq [
                               FakeFlixConsumer::Movie.new(
                                 title: "Antes do Amanhecer",
                                 genre_id: 2
                               ),
                               FakeFlixConsumer::Movie.new(
                                 title: "Titanic",
                                 genre_id: 2
                               )
                             ]
      end
    end
  end
end
