class Content < ApplicationRecord
  attr_accessor :error
  validates_presence_of :page_url
  validates_uniqueness_of :page_url
  validate :page_parsed

  def page_parsed
    errors.add(:base, 'unable to successfully parse page url') if self.error
  end
end
