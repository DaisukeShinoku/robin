# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leagues", type: :request do
  describe "GET /index" do
    it "leagueの一覧が取得できる" do
      create_list(:league, 5)
      get leagues_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json.length).to eq(5)
    end
  end

  describe "POST /create" do
    it "正しいパラメーターが渡ったときleagueが作成できる" do
      valid_params = { name: "name" }
      expect { post leagues_path, params: valid_params }.to change(League, :count).by(1)
      expect(response).to have_http_status(201)
    end

    it "不正なパラメーターが渡ったときleagueが作成できない" do
      invalid_params = { name: nil }
      expect { post leagues_path, params: invalid_params }.to change(League, :count).by(0)
      expect(response).to have_http_status(422)
    end
  end
end
