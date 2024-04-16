# frozen_string_literal: true

class League < ApplicationRecord
  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players

  validates :name, presence: true, length: { maximum: 50 }
  validate :players_size_over, :players_size_under

  PLAYERS_MAX = 10
  PLAYERS_MIN = 4

  def players_size_over
    errors.add(:players, "は#{PLAYERS_MAX}人以内で登録してください") if players.size > PLAYERS_MAX
  end

  def players_size_under
    errors.add(:players, "は#{PLAYERS_MIN}人以上で登録してください") if players.size < PLAYERS_MIN
  end
end
