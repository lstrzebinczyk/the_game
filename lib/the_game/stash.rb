class TheGame
  class Stash
    def initialize
      @content = []
    end

    def add(food)
      @content << food
    end

    def <<(item)
      @content << item
    end

    def get_food
      #because there is nothing else than food possible
      @content.pop
    end

    def has_food?
      @content.any?
    end
  end
end
