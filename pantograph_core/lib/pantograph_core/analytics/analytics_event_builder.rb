module PantographCore
  class AnalyticsEventBuilder
    attr_accessor :action_name

    # pantograph_client_language valid options are :ruby
    def initialize(p_hash: nil, session_id: nil, action_name: nil, pantograph_client_language: :ruby)
      @p_hash = p_hash
      @session_id = session_id
      @action_name = action_name
      @pantograph_client_language = pantograph_client_language
    end

    def new_event(action_stage)
      {
        client_id: @p_hash,
        category: "pantograph Client Language - #{@pantograph_client_language}",
        action: action_stage,
        label: action_name,
        value: nil
      }
    end
  end
end
