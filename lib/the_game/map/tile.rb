class TheGame
  class Map
    class Tile
      include TheGame::HasPosition

      attr_accessor :content, :terrain

      def initialize(x, y, map)
        self.x = x
        self.y = y
        @map = map
      end

      def mark_for_cleaning!
        unless empty?
          @mark_for_cleaning = true
        end
      end

      def cleaned!
        @mark_for_cleaning = false
      end

      def marked_for_cleaning?
        @mark_for_cleaning == true
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
        if @content.is_a? Nature::BerriesBush and @content.empty?
          @content = nil
          cleaned! if marked_for_cleaning?
        elsif @content.is_a? Nature::Tree and @content.cut?
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
        elsif @content.is_a? Nature::Tree::Piece and @content.cut?
          @content = Item::Log.new(@x, @y)
          Settlement.instance.stuff_to_bring << self
        end
      end
    end
  end
end
