require 'net/http'
require 'json'
module FakeFlixConsumer
  class Client
    attr_reader :title, :id, :image, :average, :genre_id, :director_id

    def show_movie(movie_id)
      hash = request "/movies/#{movie_id}"
      movies_from hash
    end

    def list_movies
      list = request "/movies"
      # aqui, o list vai retornar um hash. precisamos do map para transformar cada hash em objeto
      list.map { |h| movies_from h }
    end

    def list_movies_by_genre(genre_id)
      list = request "/movies?genre_id=#{genre_id}"
      list.map { |movie| Movie.new(title: movie['title'], genre_id: movie['genre_id']) }
    end

    def create_movie(title:, genre_id:, director_id:)
      result = request "/movies", method: :post, body: {
        movie: {
          title: title,
          genre_id: genre_id,
          director_id: director_id,
        }
      }
      movies_from result
    end

    def create_director(director_name:)
      result = request "/directors", method: :post, body: {
        director: {
          director_name: director_name
        }
      }
      directors_from result
    end

    def list_directors
      list = request "/directors"
      list.map { |h| directors_from h }

    end

    def create_genre(name:)
      result = request "/genres", method: :post, body: {
        genre: {
          name: name
        }
      }
      genres_from result
    end

    def list_genres
      list = request "/genres"
      list.map { |h| genres_from h }
    end

    private

    def request(path, method: :get, body: {})
      uri = URI(FakeFlixConsumer.configuration.fake_flix_host) + path
      api_key = FakeFlixConsumer.configuration.api_key
      headers = { "Accept" => "application/json",
                  "Authorization" => "Token token=#{api_key}",
                  "Content-type" => "application/json" }
      response = request_for(method).call(uri, headers, body.to_json)
      JSON.parse(response.body)
    end

    def movies_from(hash)
      Movie.new get_hash(hash)
    end

    def directors_from(hash)
      Director.new get_hash(hash)
    end

    def genres_from(hash)
      Genre.new get_hash(hash)
    end

    def request_for(method)
      methods = {
        get: -> (uri, headers, _) { Net::HTTP.get_response(uri, headers) },
        post: -> (uri, headers, body) { Net::HTTP.post(uri, body, headers) }
      }
      methods[method]
    end

    def get_hash(hash)
      hash.transform_keys { |k| k.to_sym }
    end

  end
end