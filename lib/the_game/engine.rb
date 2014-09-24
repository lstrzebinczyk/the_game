class TheGame
  class Engine
    attr_accessor :map, :people, :time

    def initialize
      @map = Map::Generator.new.generate
      @people = []
      generate_people!
      TheGame::Settlement.instance.people = @people

      @time = Time.new(1000, 1, 1, 12, 0, 0)
    end

    def update(time_in_minutes = 1)
      remove_dead_people!

      @people.each do |person|
        person.update(@map, time_in_minutes)
      end

      @map.update
      TheGame::Settlement.instance.update(time_in_minutes)

      @time += time_in_minutes * 60
    end

    private

    def remove_dead_people!
      @people.delete_if{|person| person.dead? }
    end

    def generate_people!
      x_center = map.height / 2
      y_center = map.width  / 2

      @people << Person::Leader.new(x: x_center, y: y_center)
      @people << Person::Woodcutter.new(x: x_center, y: y_center)
      @people << Person::Gatherer.new(x: x_center, y: y_center)
      @people << Person::Gatherer.new(x: x_center, y: y_center)

      # 5.times do
      #   @people << Person.new(x: x_center, y: y_center)
      # end
      # [-1, 0].each do |x_offset|
      #   [-1, 0].each do |y_offset|
      # # [-1, 0, 1].each do |x_offset|
      # #   [-1, 0, 1].each do |y_offset|
      #     x = x_center + x_offset
      #     y = y_center + y_offset
      #     person = Person.new(x: x, y: y)
      #     @people << person
      #   end
      # end
      # @people << Person.new(x: x_center, y: y_center, will_take_jobs: false)
      # @people << Person.new(x: x_center, y: y_center, will_take_jobs: false)
    end
  end
end
