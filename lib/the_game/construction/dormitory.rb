class TheGame
  class Construction
    class Dormitory
      include HasPosition

      attr_reader :firewood_needed
      attr_accessor :minutes_left, :status, :fields


      def initialize(x, y)
        @x = x
        @y = y
        @status = :cleaning
        @firewood_needed = 60
      end

      def description
        if @status == :plan or @status == :building
          "Dormitory construction"
        else
          "Dormitory"
        end
      end

      def terrain_clear?
        fields.all?(&:empty?)
      end

      def can_start_building?
        terrain_clear? and @status == :cleaning
      end

      def start_building!
        @status = :plan
      end

      def tile_for_cleaning(job_type)
        if job_type == :gatherer
          fields.find do |tile|
            tile.has_food?
          end
        elsif job_type == :woodcutting
          fields.find do |tile|
            tile.has_tree?
          end
        end
      end

      def needs_cleaning?(job_type)
        if job_type == :gatherer
          fields.any?(&:has_food?)
        elsif job_type == :woodcutting
          fields.any?(&:has_tree?)
        end
      end

      def need_wood?
        @firewood_needed > 0
      end

      def sleep_area
        if @status == :done
          # inside the shack
          position(x + [1, 2].sample, y + [1, 2].sample, self)
        else
          nil
        end
      end

      def ready_to_build?
        @firewood_needed == 0 and @status == :building
      end

      def add(item)
        if item.type == :firewood
          @firewood_needed -= 1
          if @firewood_needed == 0
            @status = :building
            @minutes_left = 120
          end
        end
      end

      def energy_per_minute_when_sleeping
        # this will be ok for a sleep in sort-of-good conditions
        # 3 * 0.00104167

        # sleeping on floor is way less refreshing
        2.6 * 0.00104167
      end
    end
  end
end
