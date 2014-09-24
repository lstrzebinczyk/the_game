require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash_tile, :fire_tile, :people

    def initialize
      @jobs = []
      @jobs << TheGame::Action::CheckFoodInStash.new
      @jobs << TheGame::Action::CheckFirewoodInStash.new

      @minutes_until_next_food_check = Countdown.new(16 * 60)
      @minutes_until_next_fire_check = Countdown.new(2 * 60)
      @minutes_until_next_firewood_check = Countdown.new(24 * 60)

      @minutes_left_for_fire = Countdown.new(4 * 60)
    end

    def minutes_left_for_fire
      @minutes_left_for_fire.to_i
    end

    def add_firewood_to_fire(firewood)
      @minutes_left_for_fire.add_minutes(-firewood.amount)
    end

    def fire_is_ok?
      @minutes_left_for_fire.to_i > 4 * 60
    end

    def update(minutes)
      @minutes_until_next_food_check.add_minutes(minutes)
      @minutes_until_next_fire_check.add_minutes(minutes)
      @minutes_until_next_firewood_check.add_minutes(minutes)
      @minutes_left_for_fire.add_minutes(minutes)

      if @minutes_until_next_food_check.ready?
        @jobs << TheGame::Action::CheckFoodInStash.new
        @minutes_until_next_food_check.reset!
      end

      if @minutes_until_next_fire_check.ready?
        @jobs << TheGame::Action::CheckFireplace.new
        @minutes_until_next_fire_check.reset!
      end

      if @minutes_until_next_firewood_check.ready?
        @jobs << TheGame::Action::CheckFirewoodInStash.new
        @minutes_until_next_firewood_check.reset!
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

    # job types:
    # :haul, :management, :woodcutting, :gatherer
    def get_job(person)
      person.accepted_jobs.each do |job_type|
        job = @jobs.find{|job| job.type == job_type }
        if job
          index = @jobs.index(job)
          @jobs.delete_at(index)
          return job
        end
      end
      nil
    end

    def jobs_count
      {
        haul: @jobs.count{|job| job.type == :haul },
        management: @jobs.count{|job| job.type == :management },
        woodcutting: @jobs.count{|job| job.type == :woodcutting },
        gatherer: @jobs.count{|job| job.type == :gatherer },
      }
    end

    def food_amount
      stash.food_amount
    end
  end
end
