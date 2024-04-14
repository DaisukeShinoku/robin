# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players, id: :uuid do |t|
      t.references :league, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false, limit: 20

      t.timestamps
    end
  end
end
