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
      @content[item.type] << item
    end

    def get(type)
      @content[type].pop
    end

    def has?(type)
      @content[type].any?
    end

    def count(type)
      @content[type].size
    end

    def any_axes?
      axes_count > 0
    end

    def firewood_amount
      @content[:firewood].map{|wood| wood.amount }.inject(0, &:+)
    end

    def food_amount
      @content[:food].map{|food| food.alphas }.inject(0, &:+)
    end
  end
end
