class TheGame
  class Person
    include TheGame::HasPosition

    attr_accessor :action, :thirst, :hunger, :energy, :will_take_jobs
    attr_reader :inventory, :waterskin

    def initialize(attrs = {})
      @hunger = 0.8 + rand / 10
      @energy = 0.3 + rand / 2
      @thirst = 0.8 + rand / 10

      do_stuff

      @inventory = Container.new
      @waterskin = Item::Waterskin.new

      if attrs[:will_take_jobs].nil?
        @will_take_jobs = true
      else
        @will_take_jobs = attrs[:will_take_jobs]
      end

      self.x = attrs[:x]
      self.y = attrs[:y]
    end

    def do_stuff
      @action = Action::WonderForNoReason.create
    end

    def has?(type)
      @inventory.has?(type)
    end

    def get(type)
      @inventory.get(type)
    end

    def eat(food)
      #assume this will be called as many times, as many minutes the person will eat
      @hunger += food.hunger_per_minute_added
    end

    def drink(food)
      #assume this will be called as many times, as many minutes the person will drink
      @thirst += food.thirst_per_minute_added
    end

    def can_carry_more?(item_type)
      if item_type != :firewood
        raise "I wasn't expecting that"
      else
        @inventory.count(item_type) < 5
      end
    end

    def update(map, time_in_minutes)
      update_hunger(time_in_minutes)
      update_energy(time_in_minutes)
      update_thirst(time_in_minutes)

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

    def update_thirst(minutes)
      # assume third a day is full thirst bar
      # full bar is 2 liters per day

      @thirst -= minutes / (24.0 * 60)
      if @thirst < 0
        @thirst = 0
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

    def thirsty?
      thirst < 0.65
    end

    def done_drinking?
      thirst > 0.8
    end

    def hungry?
      hunger < 0.5
    end

    def sleepy?
      energy < 0.1
    end
  end
end
