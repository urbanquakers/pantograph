module Pantograph
  # This class is used to call other actions from within actions
  # We use a separate class so that we can easily identify when
  # we have dependencies between actions
  class OtherAction
    attr_accessor :runner

    def initialize(runner)
      self.runner = runner
    end

    # Allows the user to call an action from an action
    def method_missing(method_sym, *arguments, &_block)
      # We have to go inside the pantograph directory
      # since in the pantograph runner.rb we do the following
      #   custom_dir = ".."
      #   Dir.chdir(custom_dir) do
      # this goes one folder up, since we're inside the "pantograph"
      # folder at that point
      # Since we call an action from an action we need to go inside
      # the pantograph folder too

      self.runner.trigger_action_by_name(method_sym,
                                         PantographCore::PantographFolder.path,
                                         true,
                                         *arguments)
    end
  end
end
