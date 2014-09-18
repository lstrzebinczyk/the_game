class TheGame
  class Map
    class Tile
      class Tree
        def to_s
          "x"
        end
      end

      class Null
        def to_s
          "."
        end
      end

      class Food
        def to_s
          "f"
        end
      end

      class Person
        def initialize(person)
          @person = person
        end

        def to_s
          "P"
        end
      end

      def initialize
        @content = Null.new
      end

      def set_tree
        @content = Tree.new
      end

      def set_food
        @content = Food.new
      end

      def set_person(person)
        @content = Person.new(person)
      end

      def to_s
        @content.to_s
      end
    end
  end
end
