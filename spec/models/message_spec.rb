require 'rails_helper'

RSpec.describe Message, :type => :model do
  describe "#publishing_status" do
    it "created as published" do
      message = Message.create
      expect(message.publishing_status).to eq("published")
    end

    it 'set publishing_status as published' do
      message = Message.create
      message.publishing_status = 'published'
      message.save!
      expect(message.publishing_status).to eq("published")
    end

    it 'set publishing_status as deleted' do
      message = Message.create
      message.publishing_status = 'deleted'
      message.save!
      expect(message.publishing_status).to eq("deleted")
    end
  end

  describe ".published" do
    it "retrives published messages" do
      message = Message.create(content: "published")
      message = Message.create(content: "to be deleted")
      message.publishing_status = "deleted"
      message.save!

      expect(Message.published.to_a.length).to eq(1)
    end
  end
end
