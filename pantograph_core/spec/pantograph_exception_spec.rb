describe PantographCore::Interface::PantographException do
  context 'raising pantograph exceptions' do
    it 'properly determines that it was called via `UI.user_error!`' do
      begin
        UI.user_error!('USER ERROR!!')
      rescue => e
        expect(e.caused_by_calling_ui_method?(method_name: 'user_error!')).to be(true)
      end
    end

    it 'properly determines that it was called via `UI.crash!`' do
      begin
        UI.crash!('CRASH!!')
      rescue => e
        expect(e.caused_by_calling_ui_method?(method_name: 'crash!')).to be(true)
      end
    end

    it 'properly determines that the exception was raised explicitly' do
      begin
        raise PantographCore::Interface::PantographError.new, 'EXPLICITLY RAISED ERROR'
      rescue => e
        expect(e.caused_by_calling_ui_method?(method_name: 'user_error!')). to be(false)
      end
    end
  end
end
