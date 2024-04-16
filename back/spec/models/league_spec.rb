# frozen_string_literal: true

require "rails_helper"

RSpec.describe League, type: :model do
  describe "validations" do
    it "nameがない場合は無効であること" do
      league = build(:league, name: nil)
      players = build_list(:player, League::PLAYERS_MIN, league:)
      league.players = players
      expect(league).to be_invalid
    end

    it "空文字の場合は無効であること" do
      league = build(:league, name: "")
      players = build_list(:player, League::PLAYERS_MIN, league:)
      league.players = players
      expect(league).to be_invalid
    end

    it "nameが51文字以上の場合は無効であること" do
      league = build(:league, name: "a" * 51)
      players = build_list(:player, League::PLAYERS_MIN, league:)
      league.players = players
      expect(league).to be_invalid
    end

    it "nameが50文字以下の場合は有効であること" do
      league = build(:league, name: "a" * 50)
      players = build_list(:player, League::PLAYERS_MIN, league:)
      league.players = players
      expect(league).to be_valid
    end
  end

  describe "associations" do
    it "playersが存在すること" do
      association = described_class.reflect_on_association(:players)
      expect(association.macro).to eq :has_many
    end

    it "playersが削除されること" do
      league = build(:league, name: "name")
      players = build_list(:player, League::PLAYERS_MIN, league:)
      league.players = players
      league.save
      expect { league.destroy }.to change(Player, :count).by(-League::PLAYERS_MIN)
    end
  end
end
