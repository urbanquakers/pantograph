require_relative 'ui/ui'

module PantographCore
  class PantographFolder
    FOLDER_NAME = 'pantograph'

    # Path to the pantograph folder containing the Pantfile and other configuration files
    def self.path
      value ||= "./#{FOLDER_NAME}/" if File.directory?("./#{FOLDER_NAME}/")
      value ||= "./.#{FOLDER_NAME}/" if File.directory?("./.#{FOLDER_NAME}/") # hidden folder
      value ||= "./" if File.basename(Dir.getwd) == FOLDER_NAME && File.exist?('Pantfile') # inside the folder
      value ||= "./" if File.basename(Dir.getwd) == ".#{FOLDER_NAME}" && File.exist?('Pantfile') # inside the folder and hidden
      return value
    end

    # Path to the Pantfile inside the pantograph folder. This is nil when none is available
    def self.pantfile_path
      return nil if self.path.nil?

      path = File.join(self.path, 'Pantfile')
      return path if File.exist?(path)
      return nil
    end

    # Does a pantograph configuration already exist?
    def self.setup?
      return false unless self.pantfile_path
      File.exist?(self.pantfile_path)
    end

    def self.create_folder!(path = nil)
      path = File.join(path || '.', FOLDER_NAME)
      return if File.directory?(path) # directory is already there
      UI.user_error!("Found a file called 'pantograph' at path '#{path}', please delete it") if File.exist?(path)
      FileUtils.mkdir_p(path)
      UI.success("Created new folder '#{path}'.")
    end
  end
end
