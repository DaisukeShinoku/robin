# frozen_string_literal: true

Rails.application.routes.draw do
  resources :leagues, only: %i[index create]
end
