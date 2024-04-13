# frozen_string_literal: true

class LeaguesController < ApplicationController
  def index
    leagues = League.all
    render json: leagues
  end

  def create
    league = League.new(league_params)

    if league.save
      render json: league, status: :created
    else
      render json: league.errors.full_messages.each { _1 }, status: :unprocessable_entity
    end
  end

  private

  def league_params
    params.permit(:name)
  end
end
