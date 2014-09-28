class TheGame
  class Container
    ITEM_TYPES = [:berries, :fish, :cooked_fish, :firewood, :axe, :fishing_rod]

    def initialize
      @content = {}
      @content[:berries]     = []
      @content[:axe]         = []
      @content[:firewood]    = []
      @content[:fishing_rod] = []
      @content[:fish]        = []
      @content[:cooked_fish] = []
    end

    def item_types
      ITEM_TYPES
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

    def firewood_amount
      @content[:firewood].map{|wood| wood.amount }.inject(0, &:+)
    end

    def food_amount
      @content[:berries].map{|food| food.alphas }.inject(0, &:+) + @content[:cooked_fish].map{|food| food.alphas }.inject(0, &:+)
    end
  end
end
