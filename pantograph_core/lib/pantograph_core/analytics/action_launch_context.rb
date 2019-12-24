require_relative '../helper'
# require_relative 'app_identifier_guesser'

module PantographCore
  class ActionLaunchContext
    UNKNOWN_P_HASH = 'unknown'

    attr_accessor :action_name
    attr_accessor :p_hash
    attr_accessor :platform
    attr_accessor :pantograph_client_language # example: ruby pantfile

    def initialize(action_name: nil, p_hash: UNKNOWN_P_HASH, platform: nil, pantograph_client_language: nil)
      @action_name = action_name
      @p_hash = p_hash
      @platform = platform
      @pantograph_client_language = pantograph_client_language
    end

    def self.context_for_action_name(action_name, pantograph_client_language: :ruby, args: nil)
      # app_id_guesser = PantographCore::AppIdentifierGuesser.new(args: args)
      return self.new(
        action_name: action_name,
        p_hash: UNKNOWN_P_HASH,
        # platform: nil,
        pantograph_client_language: pantograph_client_language
      )
    end

    def build_tool_version
      case platform
      when :linux
        return 'linux'
      when :windows
        return 'windows'
      else
        return "Xcode #{Helper.xcode_version}"
      end
    end
  end
end
