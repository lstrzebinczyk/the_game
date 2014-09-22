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
      x_center = map.height / 2
      y_center = map.width  / 2

      [-1, 0, 1].each do |x_offset|
        [-1, 0, 1].each do |y_offset|
          x = x_center + x_offset
          y = y_center + y_offset
          person = Person.new(x: x, y: y)
          @people << person
        end
      end
    end
  end
end
