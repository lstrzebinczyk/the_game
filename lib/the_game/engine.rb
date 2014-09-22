class TheGame
  class Engine
    attr_accessor :map, :people

    def initialize
      @map = Map::Generator.new.generate
      @people = []
      generate_people!
    end

    def update(time_in_minutes = 60)
      remove_dead_people!

      @people.each do |person|
        person.update(@map, time_in_minutes)
      end

      @map.update
    end

    private

    def remove_dead_people!
      @people.delete_if{|person| person.dead? }
    end

    def generate_people!
      srand
      20.times do
        x = rand(map.height)
        y = rand(map.width)
        while !@map.fetch(x, y).passable?
          x = rand(map.height)
          y = rand(map.width)
        end
        person = Person.new(x: x, y: y)
        @people << person
      end
    end
  end
end
