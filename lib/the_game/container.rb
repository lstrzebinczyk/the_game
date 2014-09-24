class TheGame
  class Container
    def initialize
      @content = {}
      @content[:food]     = []
      @content[:axe]      = []
      @content[:firewood] = []
    end

    def food
      @content[:food]
    end

    def axes
      @content[:axe]
    end

    def add(item)
      if item.is_a? food_class
        @content[:food] << item
      elsif item.is_a? axe_class
        @content[:axe] << item
      elsif item.is_a? firewood_class
        @content[:firewood] << item
      end
    end

    def get_food
      @content[:food].pop
    end

    def get_axe
      @content[:axe].pop
    end

    def get_firewood
      @content[:firewood].pop
    end

    def has_food?
      @content[:food].any?
    end

    def has_firewood?
      @content[:firewood].any?
    end

    def food_count
      @content[:food].size
    end

    def any_axes?
      axes_count > 0
    end

    def firewood_count
      @content[:firewood].size
    end

    def axes_count
      @content[:axe].size
    end

    def firewood_amount
      @content[:firewood].map{|wood| wood.amount }.inject(0, &:+)
    end

    def food_amount
      @content[:food].map{|food| food.alphas }.inject(0, &:+)
    end

    private

    def firewood_class
      TheGame::Item::Firewood
    end

    def axe_class
      TheGame::Item::Axe
    end

    def food_class
      TheGame::Item::Food
    end
  end
end
