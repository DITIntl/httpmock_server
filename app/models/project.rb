# frozen_string_literal: true

# Project is a way to organize your API endpoints
class Project < ApplicationRecord
  belongs_to :user

  has_many :endpoints, dependent: :destroy

  before_validation :strip_whitespace

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  before_create :generate_subdomain

  private

  def strip_whitespace
    self.name = name.strip
    self.description = description.strip
  end

  def generate_subdomain
    self.subdomain = SecureRandom.hex(16)
  end
end
