require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash
    attr_accessor :people
    attr_accessor :firewood_needed
    attr_accessor :fireplace, :dormitory
    attr_accessor :stuff_to_bring

    def initialize
      @dormitory = nil
      @fireplace = nil
      @stash     = nil
      @stuff_to_bring = []
    end

    def get_job(person)
      person.accepted_jobs.each do |job_type|
        if job_type == :survival and !@fireplace.fire_is_ok? and @stash.has?(:firewood)
          return Action::CheckFireplace.create()
        elsif job_type == :gatherer
          if needs_cleaning?(:gatherer)
            tile = @dormitory.tile_for_cleaning(:gatherer)
            return Action::FetchFood.create(tile.content)
          elsif need_more_food?
            return Action::LookForFoodToHarvest.create()
          end
        elsif job_type == :woodcutting
          if needs_cleaning?(:woodcutting)
            tile = @dormitory.tile_for_cleaning(:woodcutting)
            return Action::Get.create(:axe, from: @stash).then(Action::CutTree.create(tile.content))
          elsif need_more_wood?
            if @stash.has?(:log)
              return Action::CutLogIntoFirewood.create()
            else
              return Action::LookForTreeToCut.create()
            end
          end
        elsif job_type == :haul
          if needs_cleaning?(:haul)
            tile = @dormitory.tile_for_cleaning(:haul)
            action = Action::Supply.create(@stash, with: :firewood, from: tile.content)
            return action
          elsif @dormitory and @dormitory.need_wood? and @dormitory.status == :plan and @stash.has?(:firewood)
            action = Action::Supply.create(@dormitory, with: :firewood, from: @stash)
            return action
          elsif @stuff_to_bring.any?
            stuff = @stuff_to_bring.first
            return Action::MoveContent.create(:log, from: stuff, to: @stash)
          end
        elsif job_type == :management
          if @dormitory.nil?
            return Action::PlanDormitoryBuilding.create
          elsif @dormitory and @dormitory.can_start_building?
            @dormitory.start_building!
            person.do_stuff
          end
        elsif job_type == :building and @dormitory and @dormitory.ready_to_build?
          return Action::Construction.create(@dormitory)
        elsif job_type == :fisherman
          return Action::GoFishing.create()
        elsif job_type == :cooking and @stash.has?(:fish)
          return Action::Cook.create(:fish)
        end
      end

      nil
    end

    def needs_cleaning?(job_type)
      @dormitory and @dormitory.needs_cleaning?(job_type)
    end

    def need_more_wood?
      # we need enough wood for the fireplace to burn for 2 days (2 * 24 * 60 minutes)
      expected_firewood = 2 * 24

      #if dormitory needs more wood to be built, add it
      expected_firewood += @dormitory.firewood_needed if @dormitory

      available_firewood = stash.count(:firewood)

      available_firewood < expected_firewood
    end

    def need_more_food?
      @stash.food_amount < people_count
    end

    def jobs_count
      {
        haul: @jobs.count{|job| job.type == :haul },
        management: @jobs.count{|job| job.type == :management },
        woodcutting: @jobs.count{|job| job.type == :woodcutting },
        gatherer: @jobs.count{|job| job.type == :gatherer },
      }
    end

    def set_position(x, y)
      @x = x
      @y = y
    end

    def setup
      # @fireplace = Construction::Fireplace.new(@x, @y)
    end

    def safe_place_to_sleep
      @dormitory.sleep_area || @fireplace.sleep_area
    end

    def update(minutes)
      @fireplace.update(minutes)
      @stuff_to_bring.delete_if(&:empty?)
    end

    def people_count
      @people.size
    end

    def food_amount
      stash.food_amount
    end
  end
end
