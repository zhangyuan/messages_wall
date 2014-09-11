require "rails_helper"

describe Wall do
  describe 'token' do
    it 'should be created with token' do
      w = Wall.create!(title: "Messages Wall")
      expect(w.token).to be_present
      expect(w.token.length).to eq(40)
    end
  end
end
