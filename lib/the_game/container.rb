class TheGame
  class Container
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

    def food_count
      @content.size
    end

    def food_amount
      @content.map{|food| food.alphas }.inject(0, &:+)
    end
  end
end
