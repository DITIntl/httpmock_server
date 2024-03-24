# frozen_string_literal: true

# This migration removes the subdomain column from the projects table
class RemoveSubdomainFromProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :subdomain, :string
  end
end
