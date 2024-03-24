# frozen_string_literal: true

# This migration creates the endpoints table
class CreateEndpoints < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :endpoints do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :request_path, null: false
      t.string :request_method, null: false
      t.integer :response_status_code, null: false
      t.text :response_body
      t.text :response_headers
      t.integer :delay_in_milliseconds
      t.string :lookup_hash, null: false
      t.text :description
      t.timestamps
    end

    add_index :endpoints, :lookup_hash, unique: true
  end
  # rubocop:enable all
end
