module Pantograph
  class SetupAndroid < Setup
    attr_accessor :json_key_file
    attr_accessor :package_name

    def setup_android
      self.platform = :android

      welcome_to_pantograph

      self.pantfile_content = pantfile_template_content

      fetch_information_for_appfile

      PantographCore::PantographFolder.create_folder!

      self.append_lane([
                         "desc \"Runs all the tests\"",
                         "lane :test do",
                         "  gradle(task: \"test\")",
                         "end"
                       ])

      self.append_lane([
                         "desc \"Submit a new Beta Build to Crashlytics Beta\"",
                         "lane :beta do",
                         "  gradle(task: \"clean assembleRelease\")",
                         "  crashlytics",
                         "",
                         "  # sh \"your_script.sh\"",
                         "  # You can also use other beta testing services here",
                         "end"
                       ])

      self.append_lane([
                         "desc \"Deploy a new version to the Google Play\"",
                         "lane :deploy do",
                         "  gradle(task: \"clean assembleRelease\")",
                         "  upload_to_play_store",
                         "end"
                       ])

      self.lane_to_mention = "test"

      finish_up
    end

    def fetch_information_for_appfile
      UI.message('')
      UI.message("To avoid re-entering your package name and issuer every time you run pantograph, we'll store those in a so-called Appfile.")

      self.package_name = UI.input("Package Name (com.krausefx.app): ")
      puts("")
      puts("To automatically upload builds and metadata to Google Play, pantograph needs a service account json secret file".yellow)
      puts("Feel free to press Enter at any time in order to skip providing pieces of information when asked")
    end

    def finish_up
      self.pantfile_content.gsub!(":ios", ":android")

      super
    end
  end
end
