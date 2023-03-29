require 'net/http'
require 'json'
module FakeFlixConsumer
  class Client
    attr_reader :id, :genre_id

    def show_movie(id)
      hash = request_movies "/movies/#{id}"
      movies_from hash
    end

    def list_movies
      list = request_movies "/movies"
      # aqui, o list vai retornar um hash. precisamos do map para transformar cada hash em objeto
      list.map { |h| movies_from h }
    end

    def list_movies_by_genre(genre_id)
      list =  request_movies "/movies?genre_id=#{genre_id}"
      list.map { |movie| Movie.new(title: movie['title'], genre_id: movie['genre_id']) }

    end


    def create_movie(title:, genre_id:, director_id:)
      result = request_movies "/movies", method: :post, body: {
        movie: {
          title: title,
          genre_id: genre_id,
          director_id: director_id
        }
      }
      movies_from result
    end

    private

    def request_movies(path, method: :get, body: {})
      uri = URI(FakeFlixConsumer.configuration.fake_flix_host) + path
      headers = { "Accept" => "application/json",
                  "Authorization" => "Token token=#{ENV["FAKEFLIX_API_KEY"]}",
                  "Content-type" => "application/json" }
      response = request_for(method).call(uri, headers, body.to_json)
      JSON.parse(response.body)
    end

    def movies_from(hash)
      Movie.new(hash.transform_keys { |k| k.to_sym })
    end

    def request_for(method)
      methods = {
        get: -> (uri, headers, _) { Net::HTTP.get_response(uri, headers) },
        post: -> (uri, headers, body) { Net::HTTP.post(uri, body, headers) }
      }
      methods[method]
    end
  end
end