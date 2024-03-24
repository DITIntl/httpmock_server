# frozen_string_literal: true

# Project is a way to organize your API endpoints
class Project < ApplicationRecord
  belongs_to :user

  has_many :endpoints, dependent: :destroy

  before_validation :strip_whitespace

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  def subdomain
    id
  end

  private

  def strip_whitespace
    self.name = name.strip
    self.description = description.strip
  end
end
