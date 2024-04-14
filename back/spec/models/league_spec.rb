# frozen_string_literal: true

require "rails_helper"

RSpec.describe League, type: :model do
  describe "validations" do
    it "nameがない場合は無効であること" do
      league = build(:league, name: nil)
      expect(league).to be_invalid
    end

    it "空文字の場合は無効であること" do
      league = build(:league, name: "")
      expect(league).to be_invalid
    end

    it "nameが50文字以上の場合は無効であること" do
      league = build(:league, name: "a" * 51)
      expect(league).to be_invalid
    end

    it "nameが50文字以下の場合は有効であること" do
      league = build(:league, name: "a" * 50)
      expect(league).to be_valid
    end
  end

  describe "associations" do
    it "playersが存在すること" do
      association = described_class.reflect_on_association(:players)
      expect(association.macro).to eq :has_many
    end

    it "playersが削除されること" do
      league = create(:league)
      create_list(:player, 3, league:)
      expect { league.destroy }.to change(Player, :count).by(-3)
    end
  end
end
