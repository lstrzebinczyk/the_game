class TheGame
  class Nature
    class Tree
      class Piece
        attr_reader :x, :y

        def initialize(x, y)
          @x = x
          @y = y
        end

        def cut!
          @cut = true
        end

        def cut?
          @cut
        end

        def description
          "fallen tree piece"
        end
      end
    end
  end
end
