# frozen_string_literal: true

# Create the users table
class CreateUsers < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :key
      t.datetime :confirmed_at
      t.string :unconfirmed_email
      t.string :provider, null: false
      t.string :password_digest, null: false
      t.timestamps
    end

    add_index :users, :key, unique: true
    add_index :users, %i[email provider], unique: true
  end
  # rubocop:enable Metrics/MethodLength
end
