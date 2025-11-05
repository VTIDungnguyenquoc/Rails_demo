class BookCategory < ApplicationRecord
  validates :name, presence: true
  validates :image_url, length: { maximum: 500 }, allow_blank: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  # description optional
end
