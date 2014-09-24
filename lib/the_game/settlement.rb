require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash_tile, :fire_tile, :people

    def initialize
      @jobs = []
      @jobs << TheGame::Action::CheckFoodInStash.new
      @jobs << TheGame::Action::CheckFirewoodInStash.new

      @minutes_until_next_food_check = 16 * 60
      @minutes_until_next_fire_check = 2 * 60
      @minutes_until_next_firewood_check = 24 * 60

      @minutes_left_for_fire = 4 * 60
    end

    def minutes_left_for_fire
      @minutes_left_for_fire
    end

    def add_firewood_to_fire(firewood)
      @minutes_left_for_fire += firewood.amount
    end

    def fire_is_ok?
      @minutes_left_for_fire > 4 * 60
    end

    def update(minutes)
      @minutes_until_next_food_check     -= minutes
      @minutes_until_next_fire_check     -= minutes
      @minutes_until_next_firewood_check -= minutes

      @minutes_left_for_fire             -= minutes

      if @minutes_until_next_food_check == 0
        @jobs << TheGame::Action::CheckFoodInStash.new
        @minutes_until_next_food_check = 16 * 60
      end

      if @minutes_until_next_fire_check == 0
        @jobs << TheGame::Action::CheckFireplace.new
        @minutes_until_next_fire_check = 2 * 60
      end

      if @minutes_until_next_firewood_check == 0
        @jobs << TheGame::Action::CheckFirewoodInStash.new
        @minutes_until_next_firewood_check = 24 * 60
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
      # retrieve sample job
      # this will have to do unless we have a nice prioritizing and roles system
      job = @jobs.sample
      if job
        index = @jobs.index(job)
        @jobs.delete_at(index)
      end
      job
    end

    def food_amount
      stash.food_amount
    end
  end
end
