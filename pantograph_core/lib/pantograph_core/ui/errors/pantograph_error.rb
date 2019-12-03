require_relative 'pantograph_exception'

module PantographCore
  class Interface
    class PantographError < PantographException
      attr_reader :show_github_issues
      attr_reader :error_info

      def initialize(show_github_issues: false, error_info: nil)
        @show_github_issues = show_github_issues
        @error_info = error_info
      end

      def prefix
        '[USER_ERROR]'
      end
    end
  end
end

class Exception
  def pantograph_should_report_metrics?
    return false
  end
end
