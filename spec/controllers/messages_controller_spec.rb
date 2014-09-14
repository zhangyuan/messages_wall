require "rails_helper"

describe MessagesController do
  let!(:wall) { Wall.create!(title: "message wall") }
  describe 'create' do
    it 'creates normal messages' do
      expect {
        post :create, token: wall.token, message: {content: "normal message"}, format: 'json'
      }.to change { Message.count }.by(1)

      expect(Message.last.message_type).to eq("normal")
    end

    it 'creates normal messages' do
      expect {
        post :create, token: wall.token, message: {content: "normal message", message_type: 'sticky'}, format: 'json'
      }.to change { Message.count }.by(1)

      expect(Message.last.message_type).to eq("sticky")
    end

  end
end
