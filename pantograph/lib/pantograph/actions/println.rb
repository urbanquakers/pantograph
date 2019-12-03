module Pantograph
  module Actions
    require 'pantograph/actions/puts'
    class PrintlnAction < PutsAction
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Alias for the `puts` action"
      end
    end
  end
end
