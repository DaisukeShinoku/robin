# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games, id: :uuid do |t|
      t.references :league, type: :uuid, null: false, foreign_key: true
      t.references :home_ad_player, type: :uuid, null: false, foreign_key: { to_table: :players }
      t.references :home_deuce_player, type: :uuid, null: false, foreign_key: { to_table: :players }
      t.references :away_ad_player, type: :uuid, null: false, foreign_key: { to_table: :players }
      t.references :away_deuce_player, type: :uuid, null: false, foreign_key: { to_table: :players }
      t.integer :turn, null: false
      t.integer :home_score, null: false
      t.integer :away_score, null: false

      t.timestamps
    end
  end
end
