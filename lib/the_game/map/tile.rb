class TheGame
  class Map
    class Tile
      class NullContent
        def type
        end

        def nil?
          true
        end

        # meaning, it does not need to be updated
        def empty?
          false
        end
      end

      include TheGame::HasPosition

      attr_accessor :content, :terrain
      attr_accessor :building

      def initialize(x, y, map)
        self.x = x
        self.y = y
        @map = map
        @content = NullContent.new
        @terrain = :ground
        @building = nil
      end

      def not_marked_for_cleaning?
        @building and @content.type
        # @building and @content
        # !(@content && @building).nil?
      end

      def clean!
        @content = NullContent.new
      end

      def description
        @terrain
      end

      def empty?
        @content.nil?
      end

      def set_river
        @terrain = :river
      end

      def update
        if @content.empty?
          case @content.type
          when :berries_bush
            clean!
          when :tree
            fallen_tree_pieces_to_deploy = @content.pieces_count - 1
            x = @x
            y = @y

            @content = Nature::Tree::Piece.new(x, y)
            x += 1

            while fallen_tree_pieces_to_deploy > 0
              tile = @map.fetch(x, y)
              if tile.empty?
                fallen_tree_piece = Nature::Tree::Piece.new(x, y)
                tile.content = fallen_tree_piece
                fallen_tree_pieces_to_deploy -= 1
              end
              x += 1
            end
          when :tree_piece
            @content = Item::Log.new(@x, @y)
            Settlement.instance.stuff_to_bring << self
          end
        end
      end
    end
  end
end
