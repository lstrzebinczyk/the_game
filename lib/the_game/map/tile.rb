class TheGame
  class Map
    class Tile
      include TheGame::HasPosition

      attr_accessor :content, :terrain

      def initialize(x, y)
        self.x = x
        self.y = y
      end

      def mark_for_cleaning!
        @mark_for_cleaning = true unless empty?
      end

      def cleaned!
        @mark_for_cleaning = false
      end

      def updated?
        @updated
      end

      def need_update!
        @updated = false
      end

      def updated!
        @updated = true
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
        if @content.is_a? Construction::FallenTree and @content.empty?
          @content = nil
          cleaned! if marked_for_cleaning?
          need_update!
        elsif @content.is_a? Nature::BerriesBush and @content.empty?
          @content = nil
          cleaned! if marked_for_cleaning?
          need_update!
        elsif @content.is_a? Nature::Tree and @content.cut?
          fallen_tree = TheGame::Construction::FallenTree.new(@x, @y)
          @content = fallen_tree
          Settlement.instance.fallen_trees << fallen_tree
          need_update!
        end
      end
    end
  end
end
