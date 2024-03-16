# frozen_string_literal: true

# Project is a way to organize your API endpoints
class Project < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
