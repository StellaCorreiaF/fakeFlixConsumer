# frozen_string_literal: true

require_relative "fakeFlixConsumer/version"
require_relative "fakeFlixConsumer/movie"
require_relative "fakeFlixConsumer/client"

module FakeFlixConsumer
  class Error < StandardError; end

  class << self
    def configure
      @config = Configuration.new
      yield(@config)
    end

    def configuration
      @config
    end

    class Configuration
      attr_accessor :fake_flix_host, :api_key
    end

  end
end
