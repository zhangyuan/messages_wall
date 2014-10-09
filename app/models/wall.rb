class Wall < ActiveRecord::Base
  validates :title, presence: true

  mount_uploader :background_image, WallUploaderUploader
  mount_uploader :qrcode, WallUploaderUploader
  mount_uploader :logo, WallUploaderUploader

  has_many :messages

  before_create :generate_token

  def generate_token
    loop do 
      value = SecureRandom.hex(20)
      unless self.class.where(token: value).exists?
        self.token = value
        break
      end
    end
  end

  def to_excel(file)
    book = Spreadsheet::Workbook.new  
    sheet = book.create_worksheet
    sheet.row(0).concat %w(用户 内容 创建时间 类型)

    row = 1
    self.messages.published.find_each do |message|
      sheet.row(row).push message.remark_name, message.content, I18n.l(message.created_at, format: :long)

      if message.message_type == 'normal'
        sheet.row(row).push "用户消息"
      else
        sheet.row(row).push "主持人消息"
      end
      row += 1
    end

    book.write file.path
    file
  end
end
