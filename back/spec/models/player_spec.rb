# frozen_string_literal: true

require "rails_helper"

RSpec.describe Player, type: :model do
  let(:league) { create(:league) }

  describe "validations" do
    it "nameがない場合は無効であること" do
      player = build(:player, league:, name: nil)
      expect(player).to be_invalid
    end

    it "空文字の場合は無効であること" do
      player = build(:player, league:, name: "")
      expect(player).to be_invalid
    end

    it "nameが20文字以上の場合は無効であること" do
      player = build(:player, league:, name: "a" * 21)
      expect(player).to be_invalid
    end

    it "所属するリーグがない場合は無効であること" do
      player = build(:player, league: nil, name: "a" * 20)
      expect(player).to be_invalid
    end

    it "nameが20文字以下の場合は有効であること" do
      player = build(:player, league:, name: "a" * 20)
      expect(player).to be_valid
    end
  end
end
