class TheGame
  class Person
    class Woodcutter < Person
      def type
        :woodcutter
      end

      def accepted_jobs
        [:woodcutting, :haul]
      end

      def recently_cut_tree_at=(tree_tile)
        @recently_cut_tree_at = tree_tile
      end

      def has_personal_jobs?
        if @recently_cut_tree_at and @recently_cut_tree_at.empty?
          @recently_cut_tree_at = nil
        else
          @recently_cut_tree_at
        end
      end

      def take_personal_job
        settlement = Settlement.instance
        self.action = Action::Supply.create(settlement.stash, with: :log, from: @recently_cut_tree_at.content)
      end
    end
  end
end
