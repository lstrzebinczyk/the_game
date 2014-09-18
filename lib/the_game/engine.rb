class TheGame
  class Engine
    attr_accessor :map

    def initialize
      @map = Map::Generator.new.generate
    end

    def update
    end
  end
end
