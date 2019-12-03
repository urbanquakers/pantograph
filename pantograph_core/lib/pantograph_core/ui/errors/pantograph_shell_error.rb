require_relative 'pantograph_exception'

module PantographCore
  class Interface
    class PantographShellError < PantographException
      def prefix
        '[SHELL_ERROR]'
      end
    end
  end
end
