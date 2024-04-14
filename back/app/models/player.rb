# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :league

  validates :name, presence: true, length: { maximum: 20 }
end
