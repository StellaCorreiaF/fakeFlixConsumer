RSpec.describe FakeFlixConsumer::Movie do
  it "armazena o título do filme" do
    movie = FakeFlixConsumer::Movie.new(title: "Titanic")
    expect(movie.title).to eq "Titanic"
  end

  it "garante que filmes com o mesmo endereço de imagem são iguais" do
    movie = FakeFlixConsumer::Movie.new(
      id: 1, title: "Titanic", image:  "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"
    )

    expect(movie).to eq FakeFlixConsumer::Movie.new(
      id: 1, title: "Titanic", image:  "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"
    )

    expect(movie).to_not eq FakeFlixConsumer::Movie.new(
      id: 1, title: "Titanic", image: "https://image.tmdb.org/t/p/original/imcOp1kJsCsAFCoOtY5OnPrFbAf.jpg"
    )
  end


end