require 'uri'
require 'byebug'

class Message < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 140 }
  validates :author, presence: true, length: { maximum: 25 }
  validate :check_url

  def check_url
    return true if url == ''
    errors.add(:url, "not a valid url") unless url =~ URI::regexp
  end

  def get_post_by_author
    Message.where(author: self.author)
  end
end