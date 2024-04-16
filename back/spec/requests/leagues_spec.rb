# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leagues", type: :request do
  describe "GET /index" do
    it "leagueの一覧が取得できる" do
      league_num = 3
      league_num.times do
        league = build(:league)
        players = build_list(:player, League::PLAYERS_MIN, league:)
        league.players = players
        league.save
      end
      get leagues_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(league_num)
    end
  end

  describe "POST /create" do
    context "nameパラメーターに関するテスト" do
      let!(:players_attributes) { [{ name: "name1" }, { name: "name2" }, { name: "name3" }, { name: "name4" }] }

      it "nameがnilで渡ったときleagueが作成できない" do
        nil_params = { name: nil, players_attributes: }
        expect { post leagues_path, params: nil_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "nameが空文字で渡ったときleagueが作成できない" do
        empty_params = { name: "", players_attributes: }
        expect { post leagues_path, params: empty_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "nameが51文字以上で渡ったときleagueが作成できない" do
        longer_params = { name: "a" * 51, players_attributes: }
        expect { post leagues_path, params: longer_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["リーグ名は50文字以内で入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "不正なパラメーターが渡ったときleagueが作成できない" do
        invalid_params = { invalid: "invalid", players_attributes: }
        expect { post leagues_path, params: invalid_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["リーグ名を入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "正しいパラメーターが渡ったときleagueが作成できる" do
        valid_params = { name: "name", players_attributes: }
        expect do
          post leagues_path, params: valid_params
        end.to change(League, :count).by(1).and change(Player, :count).by(4)
        expect(response).to have_http_status(:created)
      end
    end

    context "players_attributesパラメーターに関するテスト" do
      let(:name) { "name" }

      it "players_attributesがnilで渡ったときleagueが作成できない" do
        nil_params = { name:, players_attributes: nil }
        expect { post leagues_path, params: nil_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["登録選手は4人以上で登録してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "players_attributesが空配列で渡ったときleagueが作成できない" do
        empty_params = { name:, players_attributes: [] }
        expect { post leagues_path, params: empty_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["登録選手は4人以上で登録してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "players_attributesが3人以下で渡ったときleagueが作成できない" do
        less_players = [{ name: "name1" }, { name: "name2" }, { name: "name3" }]
        less_params = { name:, players_attributes: less_players }
        expect { post leagues_path, params: less_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["登録選手は4人以上で登録してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "players_attributesが11人以上で渡ったときleagueが作成できない" do
        over_players = [
          { name: "name1" },
          { name: "name2" },
          { name: "name3" },
          { name: "name4" },
          { name: "name5" },
          { name: "name6" },
          { name: "name7" },
          { name: "name8" },
          { name: "name9" },
          { name: "name10" },
          { name: "name11" }
        ]
        over_params = { name:, players_attributes: over_players }
        expect { post leagues_path, params: over_params }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["登録選手は10人以内で登録してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "playerのnameがnilで渡ったときleagueが作成できない" do
        players_include_nil = [
          { name: "name1" },
          { name: "name2" },
          { name: "name3" },
          { name: "name4" },
          { name: nil }
        ]
        params_include_nil = { name:, players_attributes: players_include_nil }
        expect { post leagues_path, params: params_include_nil }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["選手名を入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "playerのnameが空文字で渡ったときleagueが作成できない" do
        players_include_empty = [
          { name: "name1" },
          { name: "name2" },
          { name: "name3" },
          { name: "name4" },
          { name: "" }
        ]
        params_include_empty = { name:, players_attributes: players_include_empty }
        expect { post leagues_path, params: params_include_empty }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["選手名を入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "playerのnameが21文字以上で渡ったときleagueが作成できない" do
        players_include_over = [
          { name: "name1" },
          { name: "name2" },
          { name: "name3" },
          { name: "name4" },
          { name: "a" * 21 }
        ]
        params_include_over = { name:, players_attributes: players_include_over }
        expect { post leagues_path, params: params_include_over }.to change(League, :count).by(0)
        expect(JSON.parse(response.body)).to match_array(["選手名は20文字以内で入力してください"])
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "正しいパラメーターが渡ったときleagueが作成できる" do
        players_attributes = [{ name: "name1" }, { name: "name2" }, { name: "name3" }, { name: "name4" }]
        params = { name:, players_attributes: }
        expect { post leagues_path, params: }.to change(League, :count).by(1).and change(Player, :count).by(4)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
