# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leagues", type: :request do
  describe "GET /index" do
    it "leagueの一覧が取得できる" do
      create_list(:league, 5)
      get leagues_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(5)
    end
  end

  describe "POST /create" do
    it "nameがnilで渡ったときleagueが作成できない" do
      nil_params = { name: nil }
      expect { post leagues_path, params: nil_params }.to change(League, :count).by(0)
      expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "nameが空文字で渡ったときleagueが作成できない" do
      empty_params = { name: "" }
      expect { post leagues_path, params: empty_params }.to change(League, :count).by(0)
      expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "nameが51文字以上で渡ったときleagueが作成できない" do
      longer_params = { name: "a" * 51 }
      expect { post leagues_path, params: longer_params }.to change(League, :count).by(0)
      expect(JSON.parse(response.body)).to match_array(["リーグ名は50文字以内で入力してください"])
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "不正なパラメーターが渡ったときleagueが作成できない" do
      invalid_params = { invalid: "invalid" }
      expect { post leagues_path, params: invalid_params }.to change(League, :count).by(0)
      expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "正しいパラメーターが渡ったときleagueが作成できる" do
      valid_params = { name: "name" }
      expect { post leagues_path, params: valid_params }.to change(League, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
