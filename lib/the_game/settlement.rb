require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash
    attr_accessor :people
    attr_accessor :firewood_needed
    attr_accessor :fireplace, :dormitory

    def initialize
      @jobs = []

      @dormitory = nil
      @fireplace = nil
      @stash     = nil

      @firewood_needed = 0

      @minutes_until_next_food_check = Countdown.new(16 * 60)
      @minutes_until_next_fire_check = Countdown.new(2 * 60)
      @minutes_until_next_firewood_check = Countdown.new(24 * 60)
    end

    def set_position(x, y)
      @x = x
      @y = y
    end

    def setup
      @jobs << Action::CheckFoodInStash.create
      @jobs << Action::CheckFirewoodInStash.create
      @jobs << Action::PlanDormitoryBuilding.create

      @fireplace = Construction::Fireplace.new(@x, @y)
    end

    def safe_place_to_sleep
      @dormitory.sleep_area || @fireplace.sleep_area
    end

    def update(minutes)
      @fireplace.update(minutes)

      @minutes_until_next_food_check.add_minutes(minutes)
      @minutes_until_next_fire_check.add_minutes(minutes)
      @minutes_until_next_firewood_check.add_minutes(minutes)

      if @minutes_until_next_food_check.ready?
        @jobs << TheGame::Action::CheckFoodInStash.create
        @minutes_until_next_food_check.reset!
      end

      if @minutes_until_next_fire_check.ready?
        @jobs << TheGame::Action::CheckFireplace.create
        @minutes_until_next_fire_check.reset!
      end

      if @minutes_until_next_firewood_check.ready?
        @jobs << TheGame::Action::CheckFirewoodInStash.create
        @minutes_until_next_firewood_check.reset!
      end
    end

    def people_count
      @people.size
    end

    def add_job(job)
      @jobs << job
    end

    def remove_gatherer_jobs!
      @jobs.delete_if{|job| job.type == :gatherer }
    end

    # job types:
    # :haul, :management, :woodcutting, :gatherer
    def get_job(person)
      #Try to get a job you'd prefer

      person.accepted_jobs.each do |job_type|
        job = @jobs.find{|job| job.type == job_type }
        if job
          index = @jobs.index(job)
          @jobs.delete_at(index)
          return job
        end
      end

      #try to get any job
      @jobs.pop
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
