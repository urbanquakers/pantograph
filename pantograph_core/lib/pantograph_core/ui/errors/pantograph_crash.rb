require_relative 'pantograph_exception'

module PantographCore
  class Interface
    class PantographCrash < PantographException
      def prefix
        '[PANTOGRAPH_CRASH]'
      end
    end
  end
end
