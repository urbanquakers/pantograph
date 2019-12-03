require 'pantograph_core'

require 'pantograph/version'
require 'pantograph/features'
require 'pantograph/shells'
require 'pantograph/tools'
require 'pantograph/documentation/actions_list'
require 'pantograph/actions/actions_helper' # has to be before pant_file
require 'pantograph/pant_file'
require 'pantograph/runner'
require 'pantograph/setup/setup'
require 'pantograph/lane'
require 'pantograph/junit_generator'
require 'pantograph/lane_manager'
require 'pantograph/lane_manager_base'
require 'pantograph/action'
require 'pantograph/action_collector'
require 'pantograph/supported_platforms'
require 'pantograph/configuration_helper'
require 'pantograph/one_off'
require 'pantograph/server/socket_server_action_command_executor'
require 'pantograph/server/socket_server'
require 'pantograph/command_line_handler'
require 'pantograph/documentation/docs_generator'
require 'pantograph/other_action'
require 'pantograph/plugins/plugins'
require 'pantograph/pantograph_require'

module Pantograph
  Helper = PantographCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in PantographCore
  UI = PantographCore::UI
  ROOT = Pathname.new(File.expand_path('../..', __FILE__))

  class << self
    def load_actions
      Pantograph::Actions.load_default_actions
      Pantograph::Actions.load_helpers

      if PantographCore::PantographFolder.path
        actions_path = File.join(PantographCore::PantographFolder.path, 'actions')
        @external_actions = Pantograph::Actions.load_external_actions(actions_path) if File.directory?(actions_path)
      end
    end

    attr_reader :external_actions

    def plugin_manager
      @plugin_manager ||= Pantograph::PluginManager.new
    end
  end
end
