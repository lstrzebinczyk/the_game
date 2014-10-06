class TheGame
  class Nature
    class LogPile
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
        @logs_count = 6
      end

      def has?(type)
        if type == :log
          !empty?
        end
      end

      def get(type)
        if type == :log
          if @logs_count > 0
            @logs_count -= 1
            Item::Log.new
          end
        end
      end

      def description
        "log pile"
      end

      def empty?
        @logs_count == 0
      end

      def type
        :log_pile
      end
    end
  end
end
