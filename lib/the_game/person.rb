class TheGame
  class Person
    include TheGame::HasPosition

    attr_accessor :action, :hunger, :energy, :will_take_jobs
    attr_reader :inventory

    def initialize(attrs = {})
      @hunger = 0.8 + rand / 10
      @energy = 0.3 + rand / 2

      do_stuff

      @inventory = Container.new

      if attrs[:will_take_jobs].nil?
        @will_take_jobs = true
      else
        @will_take_jobs = attrs[:will_take_jobs]
      end

      self.x = attrs[:x]
      self.y = attrs[:y]
    end

    def do_stuff
      @action = Action::WonderForNoReason.new
    end

    def has_axe?
      @inventory.any_axes?
    end

    def has_firewood?
      @inventory.has_firewood?
    end

    def update(map, time_in_minutes)
      update_hunger(time_in_minutes)
      update_energy(time_in_minutes)

      # if should_die?
      #   die!
      # end
      @action.perform(self, map, time_in_minutes)
    end

    def should_die?
      # @hunger < 0.01
    end

    def dead?
      @dead == true
    end

    def die!
      @dead = true
    end

    def update_hunger(minutes)
      # assume that 2 meals a day needed
      # an hour meal should add half the bar of hunger
      # so 60 minutes => 0.5
      # so 1 minute   => 0.5/60 (0.00834)


      @hunger -= minutes / (24.0 * 60)
      if @hunger < 0
        @hunger = 0
      end
    end

    def update_energy(minutes)
      # assume that:
      # 8 hours of sleep is enough rest for 16 hours of being awake
      # therefore energy goes from 1 to 0 in 16 hours
      # and goes back when sleeping in 8 hours
      # during one minute energy decreases by 1 / (16*60) => 0.00104167
      # lets call that beta
      # when sleeping energy increases by 3 beta
      @energy -= minutes / 960.0
      if @energy < 0
        @energy = 0
      end
    end

    def hungry?
      hunger < 0.5
    end

    def sleepy?
      energy < 0.02
    end

    def to_s
      "P"
    end
  end
end
