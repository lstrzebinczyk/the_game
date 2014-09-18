class TheGame
  class Engine
    attr_accessor :map, :people

    def initialize
      @map = Map::Generator.new.generate
      @people = []
      generate_people!
    end

    def update(time_in_minutes = 60)
      @people.each do |person|
        person.update(@map, time_in_minutes)
      end
    end

    private

    def generate_people!
      2.times do
        person = Person.new(x: 10, y: 8)
        @people << person
      end
    end
  end
end
