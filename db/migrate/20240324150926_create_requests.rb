# frozen_string_literal: true

# This migration creates the requests table
class CreateRequests < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :endpoint, null: false, foreign_key: true
      t.string :url, null: false
      t.string :method, null: false
      t.string :ip_address, null: false
      t.text :body
      t.text :headers
      t.timestamps
    end
  end
  # rubocop:enable all
end
