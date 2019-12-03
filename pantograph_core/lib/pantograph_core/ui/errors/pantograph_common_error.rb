require_relative 'pantograph_exception'

module PantographCore
  class Interface
    # Super class for exception types that we do not want to record
    # explicitly as crashes or user errors
    class PantographCommonException < PantographException; end

    # Raised when there is a build failure in xcodebuild
    class PantographBuildFailure < PantographCommonException; end

    # Raised when a test fails when being run by tools such as scan
    class PantographTestFailure < PantographCommonException; end

    # Raise this type of exception when a failure caused by a third party
    # dependency (i.e. xcodebuild, gradle, slather) happens.
    class PantographDependencyCausedException < PantographCommonException; end
  end
end
