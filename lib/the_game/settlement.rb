require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash_tile, :fire_tile, :people

    def initialize
      @jobs = [TheGame::Action::CheckFoodInStash.new]
      @minutes_until_next_food_check = 16 * 60
    end

    def update(minutes)
      @minutes_until_next_food_check -= minutes
      if @minutes_until_next_food_check == 0
        @jobs << TheGame::Action::CheckFoodInStash.new
        @minutes_until_next_food_check = 16 * 60
      end
    end

    def people_count
      @people.size
    end

    def stash
      stash_tile.content.stash
    end

    def add_job(job)
      @jobs << job
    end

    def jobs_count
      @jobs.count
    end

    def get_job
      @jobs.pop
    end

    def food_amount
      stash.food_amount
    end
  end
end
