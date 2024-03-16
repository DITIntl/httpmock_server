# frozen_string_literal: true

# Create the projects DB table
class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps
    end
  end
end
