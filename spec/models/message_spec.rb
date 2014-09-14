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

  describe "#message_type" do
    it 'created as normal by default' do
      message = Message.create(content: "sticky")
      expect(message.message_type).to eq('normal')
    end

    it "sets message_type attribute" do
      message = Message.create(content: "sticky", message_type: 'sticky')
      expect(message.message_type).to eq('sticky')
    end
  end

  describe '.sticky' do
    it 'retrives only sticky messages' do
      message = Message.create(content: "sticky", message_type: 'sticky')
      message = Message.create(content: "normal")

      stick_messages = Message.sticky.to_a
      expect(stick_messages.length).to eq(1)
      expect(stick_messages[0].content).to eq("sticky")
    end
  end

  describe '.normal' do
    it 'retrives only sticky messages' do
      message = Message.create(content: "sticky", message_type: 'sticky')
      message = Message.create(content: "normal")

      normal_messages = Message.normal.to_a
      expect(normal_messages.length).to eq(1)
      expect(normal_messages[0].content).to eq("normal")
    end
  end


  describe ".published" do
    it "retrives published messages" do
      message = Message.create(content: "published")
      message = Message.create(content: "to be deleted")
      message.publishing_status = "deleted"
      message.save!

      published_messages = Message.published.to_a
      expect(published_messages.length).to eq(1)
      expect(published_messages[0].content).to eq('published')
    end
  end
end
