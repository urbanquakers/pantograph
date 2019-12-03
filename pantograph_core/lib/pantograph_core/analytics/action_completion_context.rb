# require_relative 'app_identifier_guesser'

module PantographCore
  class ActionCompletionStatus
    SUCCESS = 'success'
    FAILED = 'failed' # pantograph crashes unrelated to user_error!
    USER_ERROR = 'user_error' # Anytime a user_error! is triggered
    INTERRUPTED = 'interrupted'
  end

  class ActionCompletionContext
    attr_accessor :p_hash
    attr_accessor :action_name
    attr_accessor :status
    attr_accessor :pantograph_client_language

    def initialize(p_hash: nil, action_name: nil, status: nil, pantograph_client_language: nil)
      @p_hash = p_hash
      @action_name = action_name
      @status = status
      @pantograph_client_language = pantograph_client_language
    end

    def self.context_for_action_name(action_name, pantograph_client_language: :ruby, args: nil, status: nil)
      # app_id_guesser = PantographCore::AppIdentifierGuesser.new(args: args)
      return self.new(
        action_name: action_name,
        p_hash: 'unknown',
        status: status,
        pantograph_client_language: pantograph_client_language
      )
    end
  end
end
