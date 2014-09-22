require_relative "person/eat"
require_relative "person/fetch_food"
require_relative "person/look_for_food"
require_relative "person/look_for_food_to_harvest"
require_relative "person/wonder_for_no_reason"
require_relative "person/harvest"
require_relative "person/carry_food_to_stash"
require_relative "person/review_camp"

class TheGame
  class Person
    include TheGame::HasPosition

    attr_accessor :action, :hunger
    attr_accessor :stash_tile
    attr_reader :inventory

    def initialize(attrs = {})
      @hunger = rand + 0.1

      @action = ReviewCamp.new

      @inventory = []

      self.x = attrs[:x]
      self.y = attrs[:y]
    end

    def is_standing_near_stash?
      close_enough_to(@stash_tile)
    end

    def get_food_from_inventory
      #because there is nothing else than food possible
      @inventory.pop
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
    end

    def hungry?
      hunger < 0.5
    end

    def to_s
      "P"
    end
  end
end
