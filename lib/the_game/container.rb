class TheGame
  class Container
    def initialize
      @content = {}
      @content[:food] = []
      @content[:axes] = []
    end

    def food
      @content[:food]
    end

    def axes
      @content[:axes]
    end

    def add(item)
      if item.is_a? food_class
        @content[:food] << item
      elsif item.is_a? axe_class
        @content[:axes] << item
      end
    end

    def get_food
      @content[:food].pop
    end

    def has_food?
      @content[:food].any?
    end

    def food_count
      @content[:food].size
    end

    def food_amount
      @content[:food].map{|food| food.alphas }.inject(0, &:+)
    end

    private

    def axe_class
      TheGame::Item::Axe
    end

    def food_class
      TheGame::Item::Food
    end
  end
end
