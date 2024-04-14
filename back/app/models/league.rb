# frozen_string_literal: true

class League < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
