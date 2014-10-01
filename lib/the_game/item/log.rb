class TheGame
  class Item
    class Log
      def type
        :log
      end

      def count(type)
        if type == :firewood
          32
        end
      end

      # meaning, rendering tile doesn't need to get updated
      def empty?
        false
      end
    end
  end
end
