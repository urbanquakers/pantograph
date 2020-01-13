require 'pantograph/actions/min_pantograph_version'

module Pantograph
  module Actions
    class PantographVersionAction < MinPantographVersionAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Alias for the `min_pantograph_version` action'
      end
    end
  end
end
