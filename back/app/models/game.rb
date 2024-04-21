# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :league
  belongs_to :home_ad_player, class_name: "Player"
  belongs_to :home_deuce_player, class_name: "Player"
  belongs_to :away_ad_player, class_name: "Player"
  belongs_to :away_deuce_player, class_name: "Player"
end
