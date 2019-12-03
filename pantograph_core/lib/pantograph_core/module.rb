require 'pantograph/boolean'

require_relative 'analytics/analytics_session'

module PantographCore
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  Boolean = Pantograph::Boolean

  # Session is used to report usage metrics.
  # If you opt out, we will not send anything.
  # You can confirm this by observing how we use the environment variable: PANTOGRAPH_OPT_OUT_USAGE
  # Specifically, in AnalyticsSession.finalize_session
  # Learn more at https://johnknapprs.github.io/pantograph/#metrics
  def self.session
    @session ||= AnalyticsSession.new
  end

  def self.reset_session
    @session = nil
  end

  # A directory that's being used to user-wide pantograph configs
  # This directory is also used for the bundled pantograph
  def self.pantograph_user_dir
    path = File.expand_path(File.join(Dir.home, ".pantograph"))
    FileUtils.mkdir_p(path) unless File.directory?(path)
    return path
  end
end
