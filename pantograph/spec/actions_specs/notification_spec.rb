describe Pantograph do
  describe Pantograph::PantFile do
    describe "notification action" do
      it "raises without a message" do
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            notification(
              title: 'hello',
              subtitle: 'hi'
            )
          end").runner.execute(:test)
        end.to raise_exception(PantographCore::Interface::PantographError, "No value found for 'message'")
      end

      it "works with message argument alone" do
        # pantograph passes default :title of 'pantograph'
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_including)

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello'
          )
        end").runner.execute(:test)
      end

      it "provides default title of 'pantograph'" do
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_including(title: 'pantograph'))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello'
          )
        end").runner.execute(:test)
      end

      it "passes all supported specified arguments to terminal-notifier" do
        args = {
          title: "My Great App",
          subtitle: "Check it out at http://store.itunes.com/abcd",
          sound: "default",
          activate: "com.apple.Safari",
          appIcon: "path/to/app_icon.png",
          contentImage: "path/to/content_image.png",
          open: "http://store.itunes.com/abcd",
          execute: "ls"
        }

        expect(TerminalNotifier).to receive(:notify).with("hello", hash_including(**args))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message:       'hello',
            title:         '#{args[:title]}',
            subtitle:      '#{args[:subtitle]}',
            sound:         '#{args[:sound]}',
            activate:      '#{args[:activate]}',
            app_icon:      '#{args[:appIcon]}',
            content_image: '#{args[:contentImage]}',
            open:          '#{args[:open]}',
            execute:       '#{args[:execute]}'
          )
        end").runner.execute(:test)
      end

      it "does not pass unspecified arguments with message argument" do
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_excluding(:subtitle, :sound, :activate, :appIcon, :contentImage, :open, :execute))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello'
          )
        end").runner.execute(:test)
      end

      it "does not pass unspecified arguments with message and title argument" do
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_excluding(:subtitle, :sound, :activate, :appIcon, :contentImage, :open, :execute))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello',
            title: 'My Great App'
          )
        end").runner.execute(:test)
      end

      it "does not pass unspecified arguments with message and subtitle argument" do
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_excluding(:sound, :activate, :appIcon, :contentImage, :open, :execute))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello',
            subtitle: 'My Great App'
          )
        end").runner.execute(:test)
      end

      it "does not pass unspecified arguments with message, title and subtitle argument" do
        expect(TerminalNotifier).to receive(:notify).with("hello", hash_excluding(:sound, :activate, :appIcon, :contentImage, :open, :execute))

        Pantograph::PantFile.new.parse("lane :test do
          notification(
            message: 'hello',
            title: 'hi',
            subtitle: 'My Great App'
          )
        end").runner.execute(:test)
      end
    end
  end
end
