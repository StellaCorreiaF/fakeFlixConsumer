# frozen_string_literal: true

RSpec.describe FakeFlixConsumer do

  describe ".configure" do
    it "armazena configurações em FakeFlixConsumer.configuration" do
      FakeFlixConsumer.configure do |config|
        config.fake_flix_host="http://localhost:3000"
      end
      expect(FakeFlixConsumer.configuration.fake_flix_host).to eq "http://localhost:3000"
    end
  end
  it "has a version number" do
    expect(FakeFlixConsumer::VERSION).not_to be nil
  end

  it" armazena o valor da api_key" do
    FakeFlixConsumer.configure do |config|
      config.api_key = "uma-chave-api-key"
    end
    expect(FakeFlixConsumer.configuration.api_key).to eq "uma-chave-api-key"
  end

end
