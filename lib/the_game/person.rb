require_relative "person/eat"
require_relative "person/fetch_food"
require_relative "person/look_for_food"
require_relative "person/wonder_for_no_reason"

class TheGame
  class Person
    attr_accessor :x, :y, :action, :hunger

    def initialize(attrs = {})
      @hunger = rand + 0.1

      @action = WonderForNoReason.new

      @x = attrs[:x]
      @y = attrs[:y]
    end

    def update(map, time_in_minutes)
      update_hunger(time_in_minutes)
      if should_die?
        die!
      end
      @action.perform(self, map)
    end

    def should_die?
      @hunger < 0.1
    end

    def dead?
      @dead == true
    end

    def die!
      @dead = true
    end

    def update_hunger(minutes)
      @hunger -= minutes.to_f / 14500
      @hunger = (@hunger * 100).to_i.to_f / 100
    end

    def distance_to(object)
      (@x - object.x) ** 2 + (@y - object.y) ** 2
    end

    def hungry?
      hunger < 0.4
    end

    def to_s
      "P"
    end
  end
end
