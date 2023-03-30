module FakeFlixConsumer
  class Director
    attr_reader :id, :name

    def initialize(props ={})
      @id = props[:id]
      @name = props[:name]
    end
  end
end

