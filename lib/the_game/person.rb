class TheGame
  class Person
    attr_reader :x, :y, :hunger, :action_description

    def initialize(attrs = {})
      @hunger = rand

      @action = :wonder

      @x = attrs[:x]
      @y = attrs[:y]
    end

    def update(map, time_in_minutes)
      update_hunger(time_in_minutes)

      case @action
      when :wonder
        wonder_for_no_reason(map)
      when :look_for_food
        look_for_food(map)
      when :fetch_food
        fetch_food(map)
      when :eat
        eat(map)
      end
    end

    def update_hunger(minutes)
      @hunger -= minutes.to_f / 14500
      @hunger = (@hunger * 100).to_i.to_f / 100

      if @hunger < 0.4
        if @action == :wonder
          @action = :look_for_food
        end
      end
    end

    def wonder_for_no_reason(map)
      @x += (rand(3) - 1)
      @y += (rand(3) - 1)

      if @x < 0
        @x = 0
      end
      if @x > map.size - 1
        @x = map.size - 1
      end
      if @y < 0
        @y = 0
      end
      if @y > map.size - 1
        @y = map.size - 1
      end
    end

    def action_description
      case @action
      when :wonder
        "just wondering..."
      when :look_for_food
        "looking for food..."
      when :fetch_food
        x = @closest_food_at_tile.x
        y = @closest_food_at_tile.y
        "fetching food at #{x}, #{y}"
      when :eat
        "eating..."
      end
    end

    def eat(map)
      unless @turns_spent_eating
        @turns_spent_eating = 3
      end

      @turns_spent_eating -= 1
      @hunger += 0.05

      if @turns_spent_eating == 0
        @action = :wonder
        @turns_spent_eating = nil
      end
    end

    def fetch_food(map)
      if @closest_food_at_tile.x == @x and @closest_food_at_tile.y == @y
        if @closest_food_at_tile.has_food?
          @closest_food_at_tile.clear
          @action = :eat
        else
          @action = :look_for_food
        end
      else
        # go to proper tile
        if @closest_food_at_tile.x < @x
          @x -= 1
        elsif @closest_food_at_tile.x > @x
          @x += 1
        end
        if @closest_food_at_tile.y < @y
          @y -= 1
        elsif @closest_food_at_tile.y > @y
          @y += 1
        end
      end
    end

    def look_for_food(map)
      closest = map.fetch(0, 0)
      map.each_tile do |tile|
        if tile.has_food?
          if distance_to(tile) < distance_to(closest)
            closest = tile
          end
        end
      end

      @closest_food_at_tile = closest
      @action = :fetch_food
    end

    def distance_to(object)
      (@x - object.x) ** 2 + (@y - object.y) ** 2
    end

    def to_s
      "P"
    end
  end
end
