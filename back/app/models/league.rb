# frozen_string_literal: true

class League < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
end
