# frozen_string_literal: true

# Adds subdomain to projects
class AddSubdomainToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :subdomain, :string, null: false, default: ''
    add_index :projects, :subdomain, unique: true
  end
end
