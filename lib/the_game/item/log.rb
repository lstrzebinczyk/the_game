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
    end
  end
end
